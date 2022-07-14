//
//  UserLoginState.swift
//  PracticeFirebase
//
//  Created by Johnny Toda on 2022/07/12.
//

import Foundation
import FirebaseAuthUI

final class UserLoginState {
    private(set) var isLogin = false

    
    func getStatus() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }

    func checkIsLogin(isLogin: Bool) -> String {
        self.isLogin = isLogin
        switch isLogin {
        case true: return "プロフィールを見る"
        case false: return "ログインする"
        }
    }
}
