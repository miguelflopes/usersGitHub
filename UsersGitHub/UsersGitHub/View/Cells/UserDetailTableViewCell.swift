//
//  UserDetailTableViewCell.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation
import UIKit

class UserDetailTableViewCell: UITableViewCell {
    
    // MARK: - Private View Elements
    
    private lazy var nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameRepositoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionRepositoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var watchersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var watchersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var updateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .black
        return label
    }()
    
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        nameStackView.addArrangedSubview(nameRepositoryLabel)
        nameStackView.addArrangedSubview(descriptionRepositoryLabel)
        watchersStackView.addArrangedSubview(watchersLabel)
        watchersStackView.addArrangedSubview(updateLabel)
        addSubview(nameStackView)
        addSubview(watchersStackView)
        
        NSLayoutConstraint.activate([
            nameStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            watchersStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 8),
            watchersStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            watchersStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            watchersStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            watchersLabel.widthAnchor.constraint(equalToConstant: 100),
            updateLabel.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    // MARK: - Public Methods
    
    func setupView(_ userDetail: UserDetailModel) {
        nameRepositoryLabel.text = StringHelper.userDetailsLabel + (userDetail.name ?? String())
        descriptionRepositoryLabel.text = userDetail.description
        watchersLabel.text = StringHelper.watchers.uppercased() + String(userDetail.watchers ?? Int())
        watchersLabel.backgroundColor = userDetail.watchers == .zero ? .red : .green
        let date = userDetail.updatedAt?.convertStringToDate()
        updateLabel.text = StringHelper.updatedLast.uppercased() + (date ?? String())
    }
}
