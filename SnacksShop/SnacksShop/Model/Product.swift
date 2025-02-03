//
//  Product.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI
import SwiftData

@Model
class Product: Identifiable {
    var id = UUID()
    var name: String
    var price: Double
    var image: String
    
    init(id: UUID = UUID(), name: String, price: Double, image: String) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
    }
}
