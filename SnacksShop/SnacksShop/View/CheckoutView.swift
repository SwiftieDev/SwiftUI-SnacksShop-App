//
//  CheckoutView.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var cart: CartViewModel
    @State private var isOrderPlaced = false
    @State private var paymentHandler = PaymentHandler()
    
    var body: some View {
        VStack {
            List {
                ForEach(cart.cartItems) { product in
                    HStack {
                        Image(product.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(product.name)
                            Text("$\(product.price, specifier: "%.2f")")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Checkout")
            
            Text("Total: $\(cart.totalPrice, specifier: "%.2f")")
                .font(.title)
                .padding()
            
            Button(action: placeOrder) {
                Text("Place Order")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $isOrderPlaced) {
                Alert(title: Text("Order Placed"), message: Text("Thank you for shopping with us!"), dismissButton: .default(Text("OK")))
            }
            
            PaymentButton(action: startApplePay)
                .frame(height: 50)
                .padding()
        }
    }
    
    func placeOrder() {
        isOrderPlaced = true
        cart.clearCart()
    }
    
    func startApplePay() {
        paymentHandler.startPayment(products: cart.cartItems, total: cart.totalPrice) { success in
            if success {
                placeOrder()
            }
        }
    }
}

#Preview {
    CheckoutView(cart: CartViewModel())
}
