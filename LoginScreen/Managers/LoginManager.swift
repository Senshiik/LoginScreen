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
    
    var currentUser: User?
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
            currentUser = try await UserApiManager().getUser()
            if currentUser?.isEmailVerified == false {
                NotificationCenter.default.post(name: .showOnBoarding, object: nil)
            }
        }
        
        return
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
