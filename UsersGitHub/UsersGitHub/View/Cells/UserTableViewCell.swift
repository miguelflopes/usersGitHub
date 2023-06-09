//
//  UserTableViewCell.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Combine
import Foundation
import UIKit

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - Private View Elements
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var userLogin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = nil
        return image
    }()
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        stackView.addArrangedSubview(userLogin)
        stackView.addArrangedSubview(avatarImage)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
            avatarImage.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    // MARK: - Private Methods
    
    private func image(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async {
            DownloadImage().loadData(url: url) { data, _ in
                if let image = data {
                    DispatchQueue.main.async {
                        self.avatarImage.image = UIImage(data: image)
                    }
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    func setupView(_ users: UsersModel) {
        userLogin.text = users.login?.firstUppercased
        image(url: users.avatarUrl ?? String())
        layoutIfNeeded()
    }
}
