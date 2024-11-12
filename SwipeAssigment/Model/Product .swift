//
//  Product .swift
//  SwipeAssigment
//
//  Created by Tamizhselvan gurusamy on 11/10/24.
//

import Foundation
import SwiftData


// Model for Product
struct Product: Codable, Identifiable, Hashable {
    var id: UUID
    var image: String?
    var price: Double
    var product_name: String
    var product_type: String
    var tax: Double
//    var isFavorite: Bool // store the current favorite status in the model
    var isFavorite: Bool {
        get { UserDefaults.standard.bool(forKey: "favorite_\(id.uuidString)") }
        set { UserDefaults.standard.set(newValue, forKey: "favorite_\(id.uuidString)") }
    }

    
//    var isFavorite: Bool {
//            get {
//                UserDefaults.standard.bool(forKey: "favorite_\(id.uuidString)")
//            }
//            set {
//                UserDefaults.standard.set(newValue, forKey: "favorite_\(id.uuidString)")
//            }
//        }
    
    init(image: String? = nil, price: Double, product_name: String, product_type: String, tax: Double) {
        self.id = UUID()
        self.image = image
        self.price = price
        self.product_name = product_name
        self.product_type = product_type
        self.tax = tax
        self.isFavorite = UserDefaults.standard.bool(forKey: "favorite_\(id.uuidString)")
    }

    func twoDecimals(number: Float) -> String {
        return String(format: "%.2f", number)
    }

    mutating func setFavorite(_ favorite: Bool) {
        isFavorite = favorite
        UserDefaults.standard.set(favorite, forKey: "favorite_\(id.uuidString)")
    }
}

// Struct to decode JSON from the API
struct ProductResponse: Decodable {

    let image: String?
    let price: Double
    let product_name: String
    let product_type: String
    let tax: Double
}

