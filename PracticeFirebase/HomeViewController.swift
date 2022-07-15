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
            showUserDetailsVC()
        } else {
            showAuthVC()
        }
    }

    private let userLoginState  = UserLoginState()
    override func viewDidAppear(_ animated: Bool) {
    }

    override func viewWillAppear(_ animated: Bool) {
        let title = userLoginState.checkIsLogin(isLogin: userLoginState.getStatus())
            loginButton.title = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        introduceAuthVC()
    }

    private func introduceAuthVC() {
        if Auth.auth().currentUser == nil {
            showAuthVC()
        }
    }

    private func showUserDetailsVC() {
        let userDetailsVC = UIStoryboard(name: UserDetailsViewController.storyboardName, bundle: nil).instantiateViewController(withIdentifier: UserDetailsViewController.identifier) as! UserDetailsViewController
        navigationController?.pushViewController(userDetailsVC, animated: true)
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
