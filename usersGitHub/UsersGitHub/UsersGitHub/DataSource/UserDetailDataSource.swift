//
//  UserDetailDataSource.swift
//  UsersGitHub
//
//  Created by hitss on 25/06/24.
//

import UIKit

final class UserDetailDataSource: NSObject, UserDetailDataSourceProtocol {
    var userDetail: [UserDetailModel]?
    
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
