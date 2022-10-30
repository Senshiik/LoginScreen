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
    
    var request: DataRequest?
    var currentUser: User?
    var savedUsers: [User: String] = [:]
    static let shared = LoginManager()
    private init() {
        
    }
    @MainActor
    func tryRegister(username: String, email: String, password: String) async throws {
        
        let tokens = await UserApiManager().requestRegister(email: email, password: password)
        if  let tokens = tokens {
            TokenManager.shared.saveTokens(tokens: tokens)
        }
        print("TOKENI", tokens?.accessToken as Any)
        RootViewModel.shared.rootScreen = .fullScreenCover
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
        currentUser = await UserApiManager().getUser()
        print(currentUser?.email as Any)
        RootViewModel.shared.rootScreen = .fullScreenCover
        
        return
    }
    
    func tryLogin(email: String, password: String) async throws {
        
        let tokens = await UserApiManager().requestLogin(email: email, password: password)
        
        if  let tokens = tokens {
            TokenManager.shared.saveTokens(tokens: tokens)
        }
        currentUser = await UserApiManager().getUser()
        print(currentUser?.email as Any)
        RootViewModel.shared.rootScreen = .fullScreenCover
        return
    }
}

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
