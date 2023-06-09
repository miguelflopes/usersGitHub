//
//  UserDetailViewController.swift
//  UsersGitHub
//
//  Created by Miguel on 15/05/23.
//

import Foundation
import UIKit

final class UserDetailViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var viewModel: UserDetailViewModelProtocol?
    private var userDetail: [UserDetailModel]?
    
    // MARK: - Public Properties
    
    var openError: ((_ title: String, _ message: String) -> ())?
    
    // MARK: - Private View Elements
    
    private lazy var loadingView = LoadingView()
    
    private lazy var avatarLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: String(describing: UserDetailTableViewCell.self))
        return tableView
    }()
    
    // MARK: - Initializers
    
    init(userName: String, viewModel: UserDetailViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        title = userName.firstUppercased
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Private Methods
    
    private func fetchUserDetails() {
        loadingView.show(on: self.view)
        viewModel?.fetchUserDetails()
    }
}

// MARK: - UITableViewDataSource

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetail?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.self.className, for: indexPath) as? UserDetailTableViewCell else {
            return UITableViewCell()
        }
        guard let user = userDetail?[indexPath.row] else { return cell }
        cell.setupView(user)
        return cell
    }
}

// MARK: - UserDetailViewModelDelegate

extension UserDetailViewController: UserDetailViewModelDelegate {
    func onUsersFetchSuccess(_ userDetail: [UserDetailModel]) {
        self.loadingView.hide()
        self.userDetail = userDetail
        self.tableView.reloadData()
    }
    
    func onUsersFetchError(_ errorTitle: String, _ errorMessage: String) {
        self.loadingView.hide()
        openError?(errorTitle, errorMessage)
    }
}
