//
//  CartView.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cart: CartViewModel
    
    var body: some View {
        VStack {
            if cart.cartItems.isEmpty {
                Text("Your cart is empty")
                    .font(.title)
                    .padding()
            } else {
                List {
                    ForEach(cart.cartItems) { product in
                        HStack {
                            Image(product.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .transition(.scale)
                            
                            VStack(alignment: .leading) {
                                Text(product.name)
                                Text("\(product.price, specifier: "%.2f")$")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: { cart.removeFromCart(product) }) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                                    .transition(.opacity)
                            }
                        }
                        .padding()
                        .animation(.easeInOut, value: cart.cartItems.count)
                    }
                }
                .navigationTitle("Cart")
                .toolbar {
                    Text("Total: \(cart.totalPrice, specifier: "%.2f")$")
                        .bold()
                        .transition(.opacity)
                }
                
                NavigationLink(destination: CheckoutView(cart: cart)) {
                    Text("Proceed to Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CartView(cart: CartViewModel(cartItems: [
            Product(name: "Chocolate Bar", price: 2.99, image: "chocolate"),
            Product(name: "Gummy Bears", price: 3.49, image: "gummy")
        ]))
    }
}
