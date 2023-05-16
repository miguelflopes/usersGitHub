//
//  UsersViewController.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation

import UIKit

class UsersViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: UsersViewModelProtocol?
    private var users: [UsersModel]?
    private let delayStartSearch: TimeInterval = 0.8
    private var searchDelay: Timer?
    
    // MARK: - Private View Elements
    
    private lazy var loadingView = ShimmerLoadingView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        return tableView
    }()
    
    private lazy var searchBar: UITextField = {
        let search = UITextField()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = StringHelper.placeholderSearch
        search.borderStyle = .line
        search.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
        return search
    }()
    
    // MARK: - Initializer
    
    init(viewModel: UsersViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    // MARK: - Private Methods
    
    private func fetchUsers() {
        viewModel?.fetchUsers()
        loadingView.show(on: view)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        title = StringHelper.title
        view.addSubview(searchBar)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    private func searchTextFieldDidChange(_ textField: UITextField) {
        searchDelay?.invalidate()
        searchDelay = Timer.scheduledTimer(withTimeInterval: delayStartSearch, repeats: false) { _ in
            guard let textField = textField.text, !textField.isEmpty else { self.fetchUsersAgain(); return }
            self.loadingView.show(on: self.view)
            self.viewModel?.search(search: textField)
        }
    }
    
    private func fetchUsersAgain() {
        loadingView.show(on: self.view)
        viewModel?.fetchUsers()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.self.className, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        guard let user = users?[indexPath.row] else { return cell }
        cell.setupView(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userLogin = users?[indexPath.row].login else { return }
        let userDetailViewModel = UserDetailViewModel(userName: userLogin)
        let viewController = UserDetailViewController(userName: userLogin, viewModel: userDetailViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UsersViewModelDelegate

extension UsersViewController: UsersViewModelDelegate {
    func onUsersFetchSuccess(_ users: [UsersModel]) {
        DispatchQueue.main.async {
            self.loadingView.hide()
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String) {
        loadingView.hide()
        AlertController().showAlert(title: errorTitle, message: errorMessage, style: .default, navigation: navigationController ?? UINavigationController()) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
