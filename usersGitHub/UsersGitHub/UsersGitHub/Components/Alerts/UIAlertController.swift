//
//  UIAlertController.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import UIKit

// MARK: - AlertController

class AlertController {
    func showAlert(title: String, message: String, style: UIAlertAction.Style, navigation: UINavigationController, completion: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: style, handler: { action in
            switch action.style {
                case .default:
                completion()
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            @unknown default:
                fatalError()
            }
        }))
        navigation.present(alert, animated: true, completion: nil)
    }
}
