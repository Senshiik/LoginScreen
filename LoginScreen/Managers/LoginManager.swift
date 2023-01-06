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
        
        let tokens = await UserApiManager().requestRegister(email: email, password: password)
        if  let tokens = tokens {
            TokenManager.shared.saveTokens(tokens: tokens)
        } else {
            logOut()
            return
        }
        print("TOKENS", tokens?.accessToken as Any)
        DispatchQueue.main.async {
        RootViewModel.shared.rootScreen = .fullScreenCover
        }
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password
        ]
        
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
        
        currentUser = try await UserApiManager().getUser()
        print(currentUser?.email as Any)
        DispatchQueue.main.async {
        RootViewModel.shared.rootScreen = .fullScreenCover
            
        }
    }
    
    func tryLogin(email: String, password: String, code: String?) async throws {
        print(#function, code)
        let tokens = try await UserApiManager().requestLogin(email: email, password: password, code: code)
        print("Tokens")
        if  let tokens = tokens {
            TokenManager.shared.saveTokens(tokens: tokens)
            currentUser = try await UserApiManager().getUser()
            DispatchQueue.main.async {
            RootViewModel.shared.rootScreen = .fullScreenCover
            }
        }
        
        return
    }
    
    func logOut() {
        DispatchQueue.main.async {
        RootViewModel.shared.rootScreen = .login
        }
        TokenManager.shared.accessToken = nil
        TokenManager.shared.refreshToken = nil
    }
    
    func delete() {
        Task {
        await UserApiManager().deleteUser()
        }
    }
}

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
