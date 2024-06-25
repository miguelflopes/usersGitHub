//
//  LoadingView.swift
//  UsersGitHub
//
//  Created by Miguel on 16/05/23.
//

import UIKit

// MARK: - LoadingView

final class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        accessibilityIdentifier = "loadingView"
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func show() {
        self.isHidden = false
    }

    func hiden() {
        self.isHidden = true
    }
}
