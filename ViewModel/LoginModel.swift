//
//  LoginModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 06.08.2022.
//

import Foundation
import SwiftUI

class LoginModel: ObservableObject {
    
    @Published var isPressed: Bool = false
    @Published var isValid: Bool = false
    @Published var textField1: String = ""
    @Published var textField2: String = ""
    @Published public var isShowingError: Bool = false
    
    func logIn() {
        if !isValidEmail(){
        isShowingError = true
        return
        }
        
        if !isValidPass(){
        isShowingError = true
        return
        }
    }
    func toggleSheet() {
        isPressed.toggle()
    }
    func isValidEmail() -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^[A-z0-9\.-]+@[A-z0-9\.-]+\.[A-z0-9]+"#)
        let range = NSRange(location: 0, length: textField1.count)
        return regexEmail.firstMatch(in: textField1, options: [], range: range) != nil
    }
    func isValidPass() -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"#)
        let range1 = NSRange(location: 0, length: textField2.count)
        return regexEmail.firstMatch(in: textField2, options: [], range: range1 ) != nil
    }
}
