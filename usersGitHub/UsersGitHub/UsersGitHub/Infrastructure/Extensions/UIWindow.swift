//
//  UIWindow.swift
//  UsersGitHub
//
//  Created by Miguel on 16/05/23.
//

import UIKit

// MARK: - UIWindow

extension UIWindow {
    static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
