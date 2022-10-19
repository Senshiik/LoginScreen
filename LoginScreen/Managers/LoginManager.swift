//
//  LoginManager.swift
//  LoginScreen
//
//  Created by Anton Demkin on 24.08.2022.
//

import Foundation
import SwiftUI
import Security

class LoginManager: ObservableObject {
    
    var currentUser: User?
    var savedUsers: [User: String] = [:]
    static let shared = LoginManager()
    private init() {
        
    }
    
    func tryRegister(username: String, email: String, password: String) async throws {
        for  (user, _) in savedUsers {
            if (user.email == email || user.username == username) {
                return
                                                                   }
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
        let newUser = User(username: username, email: email)
        savedUsers[newUser] = password
        currentUser = newUser
        RootViewModel.shared.rootScreen = .tabBar
        
        return
        }
    
    func tryLogin(email: String, password: String) async throws {
        for  (user, userPassword) in savedUsers {
            if user.email == email && userPassword == password {
                currentUser = User(username: user.username, email: email)
                RootViewModel.shared.rootScreen = .tabBar
                print(user.username)
                print("228")
                return
            }
        }
    }
}
