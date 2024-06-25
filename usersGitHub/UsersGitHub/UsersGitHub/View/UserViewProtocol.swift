//
//  UserViewProtocol.swift
//  UsersGitHub
//
//  Created by hitss on 24/06/24.
//

import UIKit

protocol UserViewProtocol where Self: UIView {
    var onFetchUser: (() -> Void)? { get set }
    var onSearch: ((String) -> Void)? { get set }
    var openDetails: ((String) -> ())? { get set }

    func setupTableView(dataSource: UsersDataSourceProtocol)
    func loadingView(isLoading: Bool)
}
