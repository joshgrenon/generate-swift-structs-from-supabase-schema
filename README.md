# Supabase SQL to Swift Struct Generator

This Swift script generates Swift structs from a Supabase SQL schema file. It's designed to automate the process of creating Swift data models that correspond to your Supabase database tables.

## Features

- Parses CREATE TABLE statements from a Supabase SQL schema file
- Generates Swift structs with properties matching table columns
- Maps Supabase SQL data types to appropriate Swift types
- Handles nullable fields
- Outputs generated structs to a Swift file

## Requirements

- Swift 5.0 or later
- macOS or Linux environment
- Supabase project with a SQL schema file

## Usage

1. Ensure you have Swift installed on your system.
2. Save the `generate.swift` script to your project directory.
3. Export your Supabase SQL schema (usually named `schema.sql`) and place it in your project root.
4. Run the script from the command line, providing the path to your SQL schema file:

```bash
swift generate.swift schema.sql
```

5. The script will generate a file named `generated.swift` in the same directory, containing the Swift structs.

### Example

Assuming your Supabase schema file is named `schema.sql` and located in your project root, you would run the script like this:

```bash
swift generate.swift schema.sql
```

This will generate a `generated.swift` file in your current directory. The generated file might look something like this:

```swift

import Foundation

struct users: Codable {
    let id: String
    let created_at: Date?
    let email: String?
    let name: String?
}

struct posts: Codable {
    let id: Int
    let created_at: Date?
    let title: String
    let content: String?
    let author_id: String
}

// ... more structs for other tables ...
```

You can then import this `generated.swift` file into your Swift project to use these structs.