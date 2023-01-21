//
//  ApiErrorsHandler.swift
//  LoginScreen
//
//  Created by Anton Demkin on 17.11.2022.
//

import Foundation

enum ApiError: Error {
    case unexpectedError
}

enum LoginError: Error {
    case totpMissed
    case totpInvalid
    case emailNotVerified
    case tokenExpired
    case invalidToken
    case unexpectedError
    case alreadyExists
}

struct ApiExceptionBody: Decodable {
    
    var detail: ApiExceptionDetail
    
}
struct ApiExceptionDetail: Decodable {
    
    enum ApiExceptionType: String, Decodable {
        case totpMissed
        case tokenExpired
        case enabled2faRequired
        case emailNotVerified
        case credentialsInvalid
        case totpInvalid
        case invalidToken
        case accessDenied
        case notFound
        case alreadyExists
        case internalServerError
        case notImplemented
        case bridgeUnavailable
    }
    var type: ApiExceptionType
    var msg: String
    enum CodingKeys: String, CodingKey {
        case type, msg
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try ApiExceptionDetail.ApiExceptionType(rawValue: container.decode(String.self, forKey: .type).toCamelCase()) ?? .notFound
        msg = (try? container.decode(String.self, forKey: .msg)) ?? "Default Value"
    }
}
