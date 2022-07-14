//
//  HomeViewController.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/04.
//

import UIKit
import FirebaseOAuthUI
import FirebaseGoogleAuthUI

private enum StoryboardKeyValue {
    static let name = "RegistValue"
    static let id = "storyboardID"
}

class HomeViewController: UIViewController {
    @IBOutlet private weak var registratedValueLabel: UILabel!

    @IBOutlet private weak var loginButton: UIBarButtonItem!
    @IBAction private func showRegistValueVC(_ sender: Any) {
        let registValueVC = UIStoryboard(name: StoryboardKeyValue.name, bundle: nil).instantiateViewController(withIdentifier: StoryboardKeyValue.id) as! RegistValueViewController

        registValueVC.completion = { self.registratedValueLabel.text = $0 }
        navigationController?.pushViewController(registValueVC, animated: true)
    }

    @IBAction private func didTapLoginButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            showLogoutAlert()
        } else {
            showAuthVC()
        }
    }

    private let userLoginState  = UserLoginState()

    private func logout() {
        do {
            try Auth.auth().signOut()
            let didFinishLogoutAlert = UIAlertController(title: "ログアウト完了", message: "またログインしてね", preferredStyle: .alert)
            didFinishLogoutAlert.addAction(UIAlertAction(title: "うい。", style: .default))
            present(didFinishLogoutAlert, animated: true)
            let title = userLoginState.checkIsLogin(isLogin: userLoginState.getStatus())
            loginButton.title = title
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

    override func viewDidAppear(_ animated: Bool) {
        if userLoginState.isLogin == false {
            showAuthVC()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: FUIAuthDelegate {
    private func showAuthVC() {
        if let authUI = FUIAuth.defaultAuthUI() {
            authUI.providers = [
                FUIOAuth.appleAuthProvider(withAuthUI: authUI),
                FUIGoogleAuth(authUI: authUI)
            ]
            authUI.delegate = self
            let authVC = authUI.authViewController()
            present(authVC, animated: true)
        }
    }

    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        let title = userLoginState.checkIsLogin(isLogin: userLoginState.getStatus())
        loginButton.title = title
    }
}
