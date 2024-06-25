//
//  UserView.swift
//  UsersGitHub
//
//  Created by hitss on 24/06/24.
//

import UIKit

final class UserView: UIView {
    // MARK: - Private Properties

    private var searchDelay: Timer?
    private let delayStartSearch: TimeInterval = 0.8

    // MARK: - Public Properties

    var onFetchUser: (() -> Void)?
    var onSearch: ((String) -> Void)?
    var openDetails: ((String) -> ())?

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
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.accessibilityIdentifier = "tableView"
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        return tableView
    }()

    private lazy var searchBar: UITextField = {
        let search = UITextField()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.borderStyle = .line
        search.textColor = .black
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.black.cgColor
        search.accessibilityIdentifier = "searchBar"
        search.attributedPlaceholder = NSAttributedString(
            string: StringHelper.placeholderSearch,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        search.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        return search
    }()

    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        buildHierarchy()
        buildConstraints()
        onFetchUser?()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { nil }

    // MARK: - Private methods

    private func buildHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(loadingView)
    }

    private func buildConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc
    private func searchTextFieldDidChange(_ textField: UITextField?) {
        searchDelay?.invalidate()
        searchDelay = Timer.scheduledTimer(withTimeInterval: delayStartSearch, repeats: false) { _ in
            guard let textField = textField?.text, !textField.isEmpty else { self.onFetchUser?(); return }
            self.loadingView(isLoading: true)
            self.onSearch?(textField)
        }
    }
}

// MARK: - UserViewProtocol

extension UserView: UserViewProtocol {
    func setupTableView(dataSource: UsersDataSourceProtocol) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.reloadData()

        dataSource.openDetails = { [weak self] userLogin in
            self?.openDetails?(userLogin)
        }
    }

    func loadingView(isLoading: Bool) {
        if isLoading {
            self.loadingView.show()
        } else {
            self.loadingView.hiden()
        }
    }
}
