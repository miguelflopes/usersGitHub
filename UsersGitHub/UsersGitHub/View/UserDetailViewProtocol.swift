//
//  UserDetailViewProtocol.swift
//  UsersGitHub
//
//  Created by hitss on 25/06/24.
//

import UIKit

protocol UserDetailViewProtocol where Self: UIView {
    func setupTableView(dataSource: UserDetailDataSourceProtocol)
    func loadingView(isLoading: Bool)
}
