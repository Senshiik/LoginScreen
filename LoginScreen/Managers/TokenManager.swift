//
//  AuthManager.swift
//  LoginScreen
//
//  Created by Anton Demkin on 20.10.2022.
//

import Foundation
import Alamofire

class TokenManager: ObservableObject {
    
    var accessToken: String? = ""
    var refreshToken: String? = ""
    
    static let shared = TokenManager()
    
    private init() {
        
        accessToken = UserDefaults.standard.string(forKey: "access_token")
        refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        
    }
    
    public func saveTokens(tokens: TokensPair) {
        
        accessToken = tokens.accessToken
        refreshToken = tokens.refreshToken
        UserDefaults.standard.set(tokens.accessToken, forKey: "access_token")
        UserDefaults.standard.set(tokens.refreshToken, forKey: "refresh_token")
        
    }
    
    public func isLoggedIn() -> Bool {
        if let accessToken = accessToken {
            return isAlive(token: accessToken)
        }
        return false
    }
    
    public func isAlive(token: String) -> Bool {
        guard
            let encodedSubstring = token.split(separator: ".")[safe: 1],
            let decodedData = Data(base64Encoded: String(encodedSubstring))
                ?? Data(base64Encoded: String(encodedSubstring) + "=="),
            let dataDict = try? JSONSerialization.jsonObject(with: decodedData, options: []) as? [String: Any],
            let expTimestamp = dataDict["exp"] as? TimeInterval
        else {
            return false
        }
        print(dataDict)
        print(Date().timeIntervalSince1970 < expTimestamp)
        return Date().timeIntervalSince1970 < expTimestamp
    }
    
}
