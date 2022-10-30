//
//  UserApi.swift
//  LoginScreen
//
//  Created by Anton Demkin on 25.10.2022.
//

import Foundation
import Alamofire

class UserApiManager: ObservableObject {

    func getUser() async -> User? {
        guard let accessToken = TokenManager.shared.accessToken
                else {return nil}
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        do {
            return try await AF.request("https://home.parker-programs.com/api/user", headers: headers).serializingDecodable(User.self).value
        } catch {
            print(#file, #function, #line, error)
            return nil
        }
    }
    func requestLogin(email: String, password: String) async -> TokensPair? {
        
        let parameters: [String: String] = [
            "username": email,
            "password": password
        ]
        
        do {
            return try await AF.request("https://home.parker-programs.com/api/user/login", method: .post, parameters: parameters, encoder: .urlEncodedForm).serializingDecodable(TokensPair.self).value
        } catch {
            print(#file, #function, #line, error)
            return nil
        }
    }
    
    func requestRegister(email: String, password: String) async -> TokensPair? {
        
        let parameters: [String: String] = [
            "username": email,
            "password": password
        ]
        
        do {
            return try await AF.request("https://home.parker-programs.com/api/user/register", method: .post, parameters: parameters, encoder: .urlEncodedForm).serializingDecodable(TokensPair.self).value
        } catch {
            print(#file, #function, #line, error)
            return nil
        }
    }
}
