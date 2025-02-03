//
//  CartViewModel.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI
import SwiftData

class CartViewModel: ObservableObject {
    @Published var cartItems: [Product] = []
    
    init(cartItems: [Product] = []) {
        self.cartItems = cartItems
    }
    
    func addToCart(_ product: Product) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
            cartItems.append(product)
        }
    }
    
    func removeFromCart(_ product: Product) {
        withAnimation(.easeInOut(duration: 0.3)) {
            cartItems.removeAll { $0.id == product.id }
        }
    }
    
    func clearCart() {
        withAnimation(.easeInOut(duration: 0.3)) {
            cartItems.removeAll()
        }
    }
     
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + $1.price }
    }
}
