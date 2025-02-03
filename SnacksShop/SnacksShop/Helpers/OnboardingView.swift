//
//  OnboardingView.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("isOnbiarding") var isOnboarding: Bool = false
    
    let pages = [
        ("Welcome to Snacks Shop", "Find the best snacks in one place", "cart.fill"),
        ("Fast & Secure Checkout", "Seamless paymeent options including Apple Pay", "creditcard.fill"),
        ("Enjoy Your Snacks!", "Get your favourite treats delivered instantly", "bag.fill")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Image(systemName: pages[index].2)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .foregroundColor(.blue)
                            .padding()
                        
                        Text(pages[index].0)
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Text(pages[index].1)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        if index == pages.count - 1 {
                            Button(action: {
                                isOnboarding = true
                            }) {
                                Text("Get Started")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    .padding(.horizontal, 40)
                            }
                        } else {
                            Button(action: {
                                withAnimation {
                                    currentPage += 1
                                }
                            }) {
                                Text("Next")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                    .padding(.horizontal, 40)
                            }
                        }
                        
                        PageIndicator(currentPage: currentPage, totalPages: pages.count)
                        
                        Spacer()
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct PageIndicator: View {
    let currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(index == currentPage ? .blue : .gray.opacity(0.5))
            }
        }
        .padding(.top, 10)
    }
}

#Preview {
    OnboardingView()
}
