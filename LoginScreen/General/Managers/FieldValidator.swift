//
//  FieldValidator.swift
//  LoginScreen
//
//  Created by Developer on 29.08.2022.
//

import Foundation

class FieldValidator {
    func isValidEmail(email: String) -> Bool {
        do {
        let regexEmail = try NSRegularExpression(pattern: #"^[A-z0-9\.-]+@[A-z0-9\.-]+\.[A-z0-9]+"#)
        let range = NSRange(location: 0, length: email.count)
        return regexEmail.firstMatch(in: email, options: [], range: range) != nil
        } catch {
            return false
        }
    }

    func isValidName(username: String) -> Bool {
        do {
        let regexEmail = try NSRegularExpression(pattern: #"^[A-z0-9]+$"#)
        let range = NSRange(location: 0, length: username.count)
        return regexEmail.firstMatch(in: username, options: [], range: range) != nil
        } catch {
            return false
        }
    }

    func isValidPass(password: String) -> Bool {
        do {
        let regexEmail = try NSRegularExpression(pattern: #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#)
        let range = NSRange(location: 0, length: password.count)
        return regexEmail.firstMatch(in: password, options: [], range: range ) != nil
        } catch {
            return false
        }
    }
}
