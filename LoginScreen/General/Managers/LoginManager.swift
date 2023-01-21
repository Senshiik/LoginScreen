//
//  LoginManager.swift
//  LoginScreen
//
//  Created by Anton Demkin on 24.08.2022.
//

import Foundation
import SwiftUI
import Security
import Alamofire

class LoginManager: ObservableObject {
    
    var currentUser: ObservableUser = .init(User())
    static let shared = LoginManager()
    private init() {
        
    }
    func tryRegister(username: String, email: String, password: String) async throws {
        
        _ = try await UserApiManager().requestRegister(email: email, password: password)
        NotificationCenter.default.post(name: .showOnBoarding, object: nil)
    }
    
    func tryLogin(email: String, password: String, code: String?) async throws {
        print(#function, code as Any)
        let tokens = try await UserApiManager().requestLogin(email: email, password: password, code: code)
        print("Tokens")
        if  let tokens = tokens {
            TokenManager.shared.saveTokens(tokens: tokens)
            try await tryGetUser()
            print(currentUser.name as Any, "Name Login")
            if currentUser.isEmailVerified == false {
                NotificationCenter.default.post(name: .showOnBoarding, object: nil)
            }
        }
        return
    }
    
    func tryGetUser() async throws {
        if let user = try await UserApiManager().getUser() {
            DispatchQueue.main.async {
                self.currentUser.name = user.name
                self.currentUser.email = user.email
                self.currentUser.username = user.username
                self.currentUser.name = user.name
                self.currentUser.lang = user.lang
                self.currentUser.country = user.country
                self.currentUser.birthdate = user.birthdate
                self.currentUser.id = user.id
                self.currentUser.isEmailVerified = user.isEmailVerified
                self.currentUser.is2faEnabled = user.is2faEnabled
                self.currentUser.registrationDate = user.registrationDate
            }
            print("Current user is: \(String(describing: currentUser.name))")
        }
    }
    
    func logOut() {
        DispatchQueue.main.async {
            RootViewModel.shared.rootScreen = .login
        }
        TokenManager.shared.cleanTokens()
    }
    
    func delete() {
        Task {
            try await UserApiManager().deleteUser()
        }
    }
}

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
