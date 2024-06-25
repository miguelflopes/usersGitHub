//
//  UserTableViewCell.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

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
        label.textColor = .black
        label.accessibilityIdentifier = "userLogin"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Initializers
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func prepareForReuse() {
        avatarImage.image = nil
        userLogin.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        selectionStyle = .none
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Private Methods

    private func buildHierarchy() {
        stackView.addArrangedSubview(userLogin)
        stackView.addArrangedSubview(avatarImage)
        addSubview(stackView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            avatarImage.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

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
