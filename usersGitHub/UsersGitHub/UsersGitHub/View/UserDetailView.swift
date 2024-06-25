//
//  UserDetailView.swift
//  UsersGitHub
//
//  Created by hitss on 25/06/24.
//

import UIKit

final class UserDetailView: UIView {
    
    // MARK: - Private View Elements

    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: String(describing: UserDetailTableViewCell.self))
        return tableView
    }()

    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        buildHierarchy()
        buildConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { nil }

    // MARK: - Private methods

    private func buildHierarchy() {
        addSubview(tableView)
        addSubview(loadingView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UserDetailViewProtocol

extension UserDetailView: UserDetailViewProtocol {
    func setupTableView(dataSource: UserDetailDataSourceProtocol) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()
    }

    func loadingView(isLoading: Bool) {
        if isLoading {
            self.loadingView.show()
        } else {
            self.loadingView.hiden()
        }
    }
}
