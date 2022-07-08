//
//  ViewController.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/03.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class RegistValueViewController: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!

    @IBAction func signIn(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Google SignIn Success!")
                }
            }
        }
    }

    @IBOutlet private weak var valueTextView: UITextView!
    @IBAction private func registValue(_ sender: Any) {
        completion?(valueTextView.text)
        navigationController?.popViewController(animated: true)
    }
    
    var completion: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
