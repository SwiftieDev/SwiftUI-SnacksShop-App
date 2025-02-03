//
//  SnacksShopApp.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI
import SwiftData
import PassKit

@main
struct SnacksShopApp: App {
    @AppStorage("isOnbiarding") var isOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                ProductListView()
                    .modelContainer(for: [Product.self])
            } else {
                OnboardingView()
            }
        }
    }
}
