//
//  UIView+Accessibility.swift
//  UsersGitHub
//
//  Created by hitss on 25/06/24.
//

import UIKit

extension UIView {
    public func findView(accessibilityIdentifier: String) -> UIView? {
        if self.accessibilityIdentifier == accessibilityIdentifier {
            return self
        } else {
            for view in subviews {
                if let childView = view.findView(accessibilityIdentifier: accessibilityIdentifier) {
                    return childView
                }
            }
        }
        return nil
    }
}
