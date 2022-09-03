//
//  FieldValidator.swift
//  LoginScreen
//
//  Created by Developer on 29.08.2022.
//

import Foundation

// TODO: 
class FieldValidator {
    func isValidEmail(email: String) -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^[A-z0-9\.-]+@[A-z0-9\.-]+\.[A-z0-9]+"#)
        let range = NSRange(location: 0, length: email.count)
        return regexEmail.firstMatch(in: email, options: [], range: range) != nil
    }

    func isValidName(email: String) -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^[A-z0-9]+$"#)
        let range = NSRange(location: 0, length: email.count)
        return regexEmail.firstMatch(in: email, options: [], range: range) != nil
    }

    func isValidPass(email: String) -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"#)
        let range1 = NSRange(location: 0, length: email.count)
        return regexEmail.firstMatch(in: email, options: [], range: range1 ) != nil
    }
}
