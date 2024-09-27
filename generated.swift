import Foundation
struct customers: Codable {
    let id: String
    let first_name: String
    let last_name: String
    let email: String
    let phone_number: String?
    let created_at: Date
    let last_purchase_date: Date?
    let total_purchases: Int
    let is_active: Bool
}

struct inventory_items: Codable {
    let id: String
    let sku: String
    let name: String
    let description: String?
    let category: String?
    let price: Decimal?
    let 2): String
    let stock_quantity: Int
    let last_restocked: Date?
    let is_discontinued: Bool
}

struct sales: Codable {
    let id: String
    let customer_id: String
    let sale_date: Date
    let total_amount: Decimal?
    let 2): String
    let payment_method: String?
    let notes: String?
}

struct sale_items: Codable {
    let id: String
    let sale_id: Int64
    let inventory_item_id: Int64
    let quantity: Int
    let unit_price: Decimal?
    let 2): String
    let discount_percentage: Decimal?
    let 2): String?
}

struct customer_preferences: Codable {
    let customer_id: String
    let preferred_contact_method: String?
    let subscribe_to_newsletter: Bool
    let favorite_categories: String?
    let last_email_sent: Date?
    let account_credit: Decimal?
    let 2): String?
    let loyalty_points: String?
    let notes: String?
}

