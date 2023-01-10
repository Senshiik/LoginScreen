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
        try await refreshIfNeeded()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
        guard let accessToken = TokenManager.shared.accessToken
        else {return nil}
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        let request = AF.request("\(baseUrl)",
                                 headers: headers)
        do {
            let user = try await request.serializingDecodable(User.self, decoder: decoder).value
            if !user.isEmailVerified {
                NotificationCenter.default.post(name: .showOnBoarding, object: nil)            }
            return user
        } catch {
            try await apiErrorHandler(request: request)
        }
        return nil
    }
    
    func verifyEmail(token: String) async throws {
        try await refreshIfNeeded()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
        let request = AF.request("\(baseUrl)/verify/\(token)", method: .post)
                                 
        do {
            let tokens = try await request.validate().serializingDecodable(TokensPair.self).value
            TokenManager.shared.saveTokens(tokens: tokens)
            NotificationCenter.default.post(name: .hideOnBoarding, object: nil)
            return
        } catch {
            try await apiErrorHandler(request: request)
        }
    }

    func resendVerification() async throws {
        try await refreshIfNeeded()

        guard let accessToken = TokenManager.shared.accessToken
        else {return}
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        let parameters: [String: String] = [:]
        let request = AF.request("\(baseUrl)/resend_verification",
                                method: .post,
                                parameters: parameters,
                                encoder: .urlEncodedForm,
                                headers: headers
        )
        do {
            _ = try await request.serializingData().value
        } catch {
            try await apiErrorHandler(request: request)
        }
    }
    
    func requestLogin(email: String, password: String, code: String? = nil) async throws -> TokensPair? {
        try await refreshIfNeeded()
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
    
    func requestRegister(email: String, password: String) async throws {
        try await refreshIfNeeded()
        let parameters: [String: String] = [
            "username": email,
            "password": password
        ]
        
        let request = AF.request("\(baseUrl)/register",
                                 method: .post,
                                 parameters: parameters,
                                 encoder: .urlEncodedForm)
        
        do {
            _ = try await request.serializingData().value
        } catch {
            try await apiErrorHandler(request: request)
        }
    }
    
    func refreshIfNeeded() async throws {
        if let accessToken = TokenManager.shared.accessToken, TokenManager.shared.isAlive(token: accessToken) {
            return
        }
        guard let refreshToken = TokenManager.shared.refreshToken else {
            LoginManager.shared.logOut()
            return
        }
        guard TokenManager.shared.isAlive(token: refreshToken) else {return LoginManager.shared.logOut()}
        let parameters: [String: String] = ["refresh_token": refreshToken]
        let request = AF.request("\(baseUrl) + /refresh", method: .post, parameters: parameters, encoder: .urlEncodedForm)
        do {
            let tokens = try await request.serializingDecodable(TokensPair.self).value
            TokenManager.shared.refreshToken = tokens.refreshToken
            TokenManager.shared.accessToken = tokens.accessToken
        } catch {
            try await apiErrorHandler(request: request)
            
        }
    }
    
    func deleteUser() async throws {
        try await refreshIfNeeded()
        guard let accessToken = TokenManager.shared.accessToken
        else {return}
        var headers = HTTPHeaders()
        headers.add(.authorization(bearerToken: accessToken))
        let request = AF.request("\(baseUrl)",
                                       method: .delete,
                                       headers: headers)
        do {
            _ = try await request.serializingData().value
            LoginManager.shared.logOut()
        } catch {
            try await apiErrorHandler(request: request)
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
        switch errorDetail.detail.type {
        case.alreadyExists:
            print("User already exists")
        case .tokenExpired:
            print("Refresh")
            try await refreshIfNeeded()
        case .totpMissed:
            throw LoginError.totpMissed
        case .invalidToken:
            throw LoginError.invalidToken
        default: throw ApiError.unexpectedError
        }
        
    }
    
}
