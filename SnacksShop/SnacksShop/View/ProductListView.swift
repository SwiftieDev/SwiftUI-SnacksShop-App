//
//  ProductListView.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI
import SwiftData

struct ProductListView: View {
    @StateObject var cart = CartViewModel(cartItems: [])
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Product.name, comparator: .localizedStandard)]) var products: [Product]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 20) {
                    ForEach(products) { product in
                        ProductCard(product: product, cart: cart)
                            .transition(.scale)
                    }
                }
                .padding()
            }
            .navigationTitle("Snacks Shop")
            .toolbar {
                NavigationLink(destination: CartView(cart: cart)) {
                    ZStack {
                        Image(systemName: "cart.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                        if cart.cartItems.count > 0 {
                            Text("\(cart.cartItems.count)")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                                .padding(5)
                                .background(.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }
                    }
                    .animation(.easeInOut, value: cart.cartItems.count)
                }
            }
        }
        .onAppear() {
            withAnimation(.easeIn(duration: 1.0)) {
                if products.isEmpty {
                    clearDatabase()
                    preloadProducts()
                }
            }
        }
    }
    
    func preloadProducts() {
        let sampleProducts = [
            Product(name: "Chocolate Bar", price: 2.99, image: "chocolate"),
            Product(name: "Potato Chips", price: 1.99, image: "chips"),
            Product(name: "Gummy Bears", price: 3.49, image: "gummy"),
            Product(name: "Cookies", price: 4.99, image: "cookies"),
            Product(name: "Granola Bar", price: 1.79, image: "granola"),
            Product(name: "Pretzels", price: 2.49, image: "pretzels"),
            Product(name: "Popcorn", price: 3.29, image: "popcorn"),
            Product(name: "Energy Drink", price: 2.99, image: "energy_drink"),
            Product(name: "Peanuts", price: 3.19, image: "peanuts"),
            Product(name: "Protein Bar", price: 2.89, image: "protein_bar"),
        ]
        for product in sampleProducts {
            if !products.contains(where: { $0.name == product.name}) {
                modelContext.insert(product)
            }
        }
    }
    
    func clearDatabase() {
        for product in products {
            modelContext.delete(product)
        }
    }
}

#Preview {
    ProductListView()
}
