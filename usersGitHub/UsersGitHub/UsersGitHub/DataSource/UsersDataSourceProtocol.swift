//
//  UsersDataSourceProtocol.swift
//  UsersGitHub
//
//  Created by hitss on 24/06/24.
//

import UIKit

protocol UsersDataSourceProtocol where Self: UITableViewDataSource & UITableViewDelegate {
    var users: [UsersModel]? { get set }
    var openDetails: ((String) -> ())? { get set }
}
