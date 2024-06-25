//
//  UserDetailDataSourceProtocol.swift
//  UsersGitHub
//
//  Created by hitss on 25/06/24.
//

import UIKit

protocol UserDetailDataSourceProtocol where Self: UITableViewDataSource & UITableViewDelegate {
    var userDetail: [UserDetailModel]? { get set }
}
