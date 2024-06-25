//
//  UsersDataSource.swift
//  UsersGitHub
//
//  Created by hitss on 24/06/24.
//

import UIKit

final class UsersDataSource: NSObject, UsersDataSourceProtocol {
    var users: [UsersModel]? = []
    var openDetails: ((String) -> ())?

    override init() { }
    
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
        openDetails?(userLogin)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
