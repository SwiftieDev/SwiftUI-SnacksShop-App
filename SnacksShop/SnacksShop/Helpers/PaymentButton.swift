//
//  PaymentButton.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI
import PassKit

struct PaymentButton: UIViewRepresentable {
    var action: () -> Void
    
    func makeUIView(context: Context) -> PKPaymentButton {
        let button = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.pay), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator {
        var action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func pay() {
           action()
        }
    }

}

