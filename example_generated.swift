import Foundation
struct users: Codable {
    let id: String
    let username: String
    let email: String
    let password_hash: String
    let created_at: Date
    let updated_at: Date
    let is_active: Bool
    let login_count: Int
    let last_login: Date?
    let CONSTRAINT: String?
    let CONSTRAINT: String?
    let CONSTRAINT: String?
}

struct products: Codable {
    let id: String
    let name: String
    let description: String?
    let price: Decimal?
    let 2): String
    let stock_quantity: Int
    let category: String?
    let is_available: Bool
    let created_at: Date
    let updated_at: Date
    let CONSTRAINT: String?
}

struct orders: Codable {
    let id: String
    let user_id: String
    let order_date: Date
    let total_amount: Decimal?
    let 2): String
    let status: String
    let shipping_address: String?
    let payment_method: String?
    let CONSTRAINT: String?
    let CONSTRAINT: String?
}

struct order_items: Codable {
    let id: String
    let order_id: Int64
    let product_id: Int64
    let quantity: Int
    let unit_price: Decimal?
    let 2): String
    let CONSTRAINT: String?
    let CONSTRAINT: String?
    let CONSTRAINT: String?
}

struct user_preferences: Codable {
    let user_id: String
    let theme: String?
    let notifications_enabled: Bool
    let weekly_newsletter: Bool
    let preferred_categories: String?
    let last_notification_check: Date?
    let account_deletion_date: Date?
    let profile_completeness: Float?
    let login_streak: Int16?
    let custom_settings: String?
    let CONSTRAINT: String?
    let CONSTRAINT: String?
}

