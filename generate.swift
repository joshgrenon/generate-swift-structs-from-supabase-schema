import Foundation

// Define SQL types to Swift types mapping
let sqlToSwiftTypes: [String: String] = [
    "integer": "Int",
    "bigint": "Int64",
    "smallint": "Int16",
    "text": "String",
    "varchar": "String",
    "char": "String",
    "boolean": "Bool",
    "timestamp": "Date",
    "timestamp with time zone": "Date",
    "date": "Date",
    "time": "Date",
    "time with time zone": "Date",
    "double precision": "Double",
    "real": "Float",
    "numeric": "Decimal",
    "decimal": "Decimal",
    "money": "Decimal",
    "jsonb": "String", // Consider using a custom JSON type or Codable struct
    "json": "String",  // Consider using a custom JSON type or Codable struct
    "uuid": "String",  // Changed from UUID to String
    "bytea": "Data",
    "interval": "TimeInterval",
    "point": "String", // Consider using a custom Point struct
    "line": "String",  // Consider using a custom Line struct
    "lseg": "String",  // Consider using a custom LineSegment struct
    "box": "String",   // Consider using a custom Box struct
    "path": "String",  // Consider using a custom Path struct
    "polygon": "String", // Consider using a custom Polygon struct
    "circle": "String", // Consider using a custom Circle struct
    "cidr": "String",
    "inet": "String",
    "macaddr": "String",
    "bit": "String",
    "bit varying": "String",
    "tsvector": "String",
    "tsquery": "String",
    "xml": "String"
]

// Function to parse SQL file and generate Swift structs
func generateSwiftStructs(from sqlFilePath: String) -> String {
    do {
        let sqlContent = try String(contentsOfFile: sqlFilePath, encoding: .utf8)
        
        // Match CREATE TABLE statements and capture the table name after "public"
        let tablePattern = try NSRegularExpression(pattern: "CREATE TABLE.*?\"public\"\\.\"(.*?)\".*?\\((.*?)\\);", options: [.dotMatchesLineSeparators])
        let matches = tablePattern.matches(in: sqlContent, options: [], range: NSRange(sqlContent.startIndex..., in: sqlContent))
        
        var swiftStructs = """
        import Foundation

        """

        for match in matches {
            guard let tableNameRange = Range(match.range(at: 1), in: sqlContent),
                  let columnsRange = Range(match.range(at: 2), in: sqlContent) else { continue }
            
            let tableName = String(sqlContent[tableNameRange])
            let columns = String(sqlContent[columnsRange])
            
            print("Processing table: \(tableName)")
            swiftStructs += "struct \(tableName): Codable {\n"
            
            let columnDefinitions = columns.components(separatedBy: ",")
            for columnDef in columnDefinitions {
                let parts = columnDef.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .whitespaces)
                guard parts.count >= 2 else { continue }
                
                let columnName = parts[0].replacingOccurrences(of: "\"", with: "")
                let sqlType = getSqlType(columnDef)
                print("  Column: \(columnName), SQL Type: \(sqlType)")
                
                let swiftType = sqlToSwiftTypes[sqlType] ?? "String"
                
                swiftStructs += "    let \(columnName): \(swiftType)\(columnDef.contains("NOT NULL") ? "" : "?")\n"
            }
            
            swiftStructs += "}\n\n"
        }

        return swiftStructs
    } catch {
        print("Error reading SQL file: \(error.localizedDescription)")
        print("Current working directory: \(FileManager.default.currentDirectoryPath)")
        print("Attempting to read file at: \(sqlFilePath)")
        return ""
    }
}

// Helper function to get SQL type from column definition
func getSqlType(_ columnDef: String) -> String {
    let lowerDef = columnDef.lowercased()
    for (sqlType, _) in sqlToSwiftTypes {
        if lowerDef.contains(sqlType) {
            return sqlType
        }
    }
    return "text" // Default to text if type is not recognized
}

// Main execution
let arguments = CommandLine.arguments
guard arguments.count > 1 else {
    print("Usage: swift generate.swift <path_to_schema.sql>")
    exit(1)
}

let sqlFilePath = arguments[1]
let generatedStructs = generateSwiftStructs(from: sqlFilePath)

if generatedStructs.isEmpty {
    print("No structs were generated. Please check the error messages above.")
} else {
    print(generatedStructs)

    // Write to a file in the root directory
    let outputPath = "./generated.swift"
    do {
        try generatedStructs.write(toFile: outputPath, atomically: true, encoding: .utf8)
        print("Generated structs have been written to \(outputPath)")
    } catch {
        print("Error writing file: \(error.localizedDescription)")
    }
}