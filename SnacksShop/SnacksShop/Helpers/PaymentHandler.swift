//
//  PaymentHandler.swift
//  SnacksShop
//
//  Created by SwiftlyDev on 28/01/2025.
//

import SwiftUI
import PassKit

class PaymentHandler: NSObject {
    func startPayment(products: [Product], total: Double, completion: @escaping (Bool) -> Void) {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.snacksshop"
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .threeDSecure
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = products.map { product in
            PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(value: product.price))
        }
        request.paymentSummaryItems.append(PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(value: total)))
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        if let controller = controller {
            controller.delegate = self
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first,
               let rootViewController = window.rootViewController {
                rootViewController.present(controller, animated: true, completion: nil)
            }
        } else {
            completion(false)
        }
    }
}

extension PaymentHandler: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        completion(.success)
    }
}
