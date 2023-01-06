//
//  UserApi.swift
//  LoginScreen
//
//  Created by Anton Demkin on 25.10.2022.
//

import Foundation
import Alamofire

class UserApiManager: ObservableObject {
    
    var baseUrl: String = "https://majordom.parker-programs.com/api/user"
    func getUser() async throws -> User? {
        
        guard let accessToken = TokenManager.shared.accessToken
        else {return nil}
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        let request = AF.request("\(baseUrl)",
                                 headers: headers)
        do {
            let user = try await request.serializingDecodable(User.self).value
            return user
        } catch {
            try await apiErrorHandler(request: request)
        }
        return nil
    }
    
    func requestLogin(email: String, password: String, code: String? = nil) async throws -> TokensPair? {
        
        var parameters: [String: String] = [
            "username": email,
            "password": password
        ]
        
        if let code {
            parameters["totp"] = code
        }
        
        let request = AF.request("\(baseUrl)/login",
                                 method: .post,
                                 parameters: parameters,
                                 encoder: .urlEncodedForm)
        do {
            let tokens = try await request.serializingDecodable(TokensPair.self).value
            return tokens
        } catch {
            try await apiErrorHandler(request: request)
        }
        return nil
    }
    
    func requestRegister(email: String, password: String) async -> TokensPair? {
        
        let parameters: [String: String] = [
            "username": email,
            "password": password
        ]
        
        do {
            return try await AF.request("\(baseUrl)/register",
                                        method: .post,
                                        parameters: parameters,
                                        encoder: .urlEncodedForm).validate().serializingDecodable(TokensPair.self).value
        } catch {
            print("ERROR")
            print(error)
            return nil
        }
    }
    
    func refresh() async {
        if let accessToken = TokenManager.shared.accessToken, TokenManager.shared.isAlive(token: accessToken) {
            return
        }
        guard let refreshToken = TokenManager.shared.refreshToken else {
            LoginManager.shared.logOut()
            return
        }
        guard TokenManager.shared.isAlive(token: refreshToken) else {return LoginManager.shared.logOut()}
        let parameters: [String: String] = ["refresh_token": refreshToken]
        do {
            let tokens = try await AF.request("\(baseUrl) + /refresh", method: .post, parameters: parameters, encoder: .urlEncodedForm).validate().serializingDecodable(TokensPair.self).value
            TokenManager.shared.refreshToken = tokens.refreshToken
            TokenManager.shared.accessToken = tokens.accessToken
        } catch {
            print("ERROR!")
            print(#file, #function, #line, error)
            
        }
    }
    
    func deleteUser() async {
        guard let accessToken = TokenManager.shared.accessToken
        else {return}
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        do {
            _ = try await AF.request("\(baseUrl)",
                                     method: .delete,
                                     headers: headers).validate().serializingData().value
            LoginManager.shared.logOut()
        } catch {
            print(#file, #function, #line, error)
            return
        }
    }
    func apiErrorHandler(request: DataRequest) async throws {
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        var errorDetail: ApiExceptionBody
        do {
            errorDetail = try await request.serializingDecodable(ApiExceptionBody.self, decoder: decoder).value
         } catch {
             print("Exception parsing error: \(error)")
             return
         }
        switch errorDetail.detail.type { // обрабатываем ошибку
        case .tokenExpired:
            print("Refresh")
            await refresh()
        case .totpMissed:
            throw LoginError.totpMissed // handle in loginVm
        case .invalidToken:
            throw LoginError.invalidToken
        default: throw ApiError.unexpectedError
        }
        
    }
    
}
