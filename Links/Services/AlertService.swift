//
//  AlertService.swift
//  Links
//
//  Created by Roman Borzdukha on 19.08.2023.
//

import UIKit

struct AlertService {
    static func showErrorAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            let rootVC = UIApplication.shared.windows.first?.rootViewController as? UIViewController
            rootVC?.present(alert, animated: true)
        }
    }
}
