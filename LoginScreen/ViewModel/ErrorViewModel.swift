//
//  ErrorViewModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 13.10.2022.
//

import Foundation

enum CustomError: Error {
    case invalidLogin

    case invalidRegistration
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidLogin:
            return "The provided password or login is not valid."
        case .invalidRegistration:
            return "User is already exists"
        }
    }
}
