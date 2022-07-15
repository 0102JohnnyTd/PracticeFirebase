//
//  UserDetailsViewController.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/14.
//

import UIKit
import FirebaseAuthUI

struct Option {
    var item: String
    var textColorType: TextColorType
}

enum TextColorType {
    case normal
    case warning
}

class UserDetailsViewController: UIViewController {
    @IBOutlet private weak var userDetailsTableView: UITableView!

    static let storyboardName = "UserDetails"
    static let identifier = String(describing: UserDetailsViewController.self)

    private let options = [Option(item: "ログアウト", textColorType: .normal), Option(item: "アカウントを削除", textColorType: .warning)]

//    private let userLoginState = UserLoginState()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    private func setUpTableView() {
        userDetailsTableView.delegate = self
        userDetailsTableView.dataSource = self

        userDetailsTableView.register(UserDetailsTableViewHeaderView.nib, forHeaderFooterViewReuseIdentifier: UserDetailsTableViewHeaderView.identifier)
//        userDetailsTableView.register(UserDetailsTableViewHeaderView.nib, forCellReuseIdentifier: UserDetailsTableViewHeaderView.identifier)
        userDetailsTableView.register(UserDetailsTableViewCell.nib, forCellReuseIdentifier: UserDetailsTableViewCell.identifier)
    }

    private func returnProfileInfomation() -> (String?, String?, URL?) {
        guard let user = Auth.auth().currentUser else { return (nil, nil, nil) }
        let name = user.displayName
        let email = user.email
        let profileImage = user.photoURL
        return (name, email, profileImage)
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
            let didFinishLogoutAlert = UIAlertController(title: "ログアウト完了", message: "またログインしてね", preferredStyle: .alert)
            didFinishLogoutAlert.addAction(UIAlertAction(title: "うい。", style: .default, handler: { [self] _ in
                navigationController?.popViewController(animated: true)
            }))
            present(didFinishLogoutAlert, animated: true)
            //            let title = userLoginState.checkIsLogin(isLogin: userLoginState.getStatus())
            //            loginButton.title = title
        } catch {
            print(error)
        }
    }

    private func showLogoutAlert() {
        let logoutAlert = UIAlertController(title: "ログアウト", message: "ログアウトしますか？", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        logoutAlert.addAction(UIAlertAction(title: "ログアウト", style: .destructive, handler: { [self] _ in
            logout()
        }))

        present(logoutAlert, animated: true, completion: nil)
    }

}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // ヘッダーを生成
        let header = userDetailsTableView.dequeueReusableHeaderFooterView(withIdentifier: UserDetailsTableViewHeaderView.identifier) as! UserDetailsTableViewHeaderView
        let profileInfomation = returnProfileInfomation()
        let height = userDetailsTableView.bounds.height / 6
        header.configure(profileInfomation: profileInfomation, height: height)

        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userDetailsTableView.dequeueReusableCell(withIdentifier: UserDetailsTableViewCell.identifier, for: indexPath) as! UserDetailsTableViewCell
        let option = options[indexPath.row]
        let textColor: UIColor = option.textColorType == .warning ? .systemRed : .black
        cell.configure(option: option.item, textColor: textColor)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0: showLogoutAlert()
        case 1: break // deleteAuth()
        default: break
        }
    }
}
