//
//  ProductCard.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    @ObservedObject var cart: CartViewModel
    @State private var animated = false
    
    var body: some View {
        VStack {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(10)
                .shadow(radius: 5)
                .scaleEffect(animated ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: animated)
                
            Text(product.name)
                .font(.headline)
                .padding(.top, 5)
                .transition(.slide)
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                animated.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animated.toggle()
                }
                cart.addToCart(product)
            }) {
                Text("Add to Cart")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .scaleEffect(animated ? 1.2 : 1.0)
                    .animation(.spring(), value: animated)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
        .transition(.opacity)
    }
}

#Preview {
    ProductCard(product: Product(name: "Chocolate Bar", price: 2.99, image: "chocolate"), cart: CartViewModel())
}
