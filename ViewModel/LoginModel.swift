//
//  LoginModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 06.08.2022.
//

import Foundation
import SwiftUI

class LoginModel: ObservableObject {
    @Published var isRegistrationMode: Bool = false
    @Published var isPressed: Bool = false
    @Published var isAlertPresented: Bool = false
    @Published var isValid: Bool = false
    @Published var isEmailValid: Bool = true
    @Published var isPassValid: Bool = true
    @Published var isPassEquals: Bool = true
    @Published var isButtonDisabled: Bool = false
    @Published var textField1: String = ""
    @Published var textField2: String = ""
    @Published var textField3: String = ""
    @Published var textField4: String = ""
    @Published public var isShowingError: Bool = false
    @Published var fails: Int = 0
    @Published var timeRemaining = 0
    @Published var errorMessageText: String = ""
    var timerCount: Int = 0
    var runCount: Int = 0
    var timerTime: Int = 0
    var timer: Timer?
    
    func logIn() {
        if !LoginManager().tryLogin() && isValidEmail() && isValidPass(){
            fails += 1
            startTimer()
            isShowingError = false
        }
        if !isValidEmail(){
        isEmailValid = false
        isShowingError = true
        }
        if !isValidPass(){
        isPassValid = false
        isShowingError = true
        }
    }
    func register1() {
        if  isValidName()  && isValidEmail() && isValidPass() && textField4 == textField2{
            isRegistrationMode.toggle()
            isShowingError = false
        }
        if !isValidEmail(){
        isEmailValid = false
        isShowingError = true
        }
        if !isValidEmail(){
        isEmailValid = false
        isShowingError = true
        }
        if !isValidPass(){
        isPassValid = false
        isShowingError = true
        }
        if textField2 != textField4 {
            isPassEquals = false
        }
    }

    func toggleSheet() {
        isPressed.toggle()
    }
    
    func toggleRegistrationMode() {
        isRegistrationMode.toggle()
        isShowingError = false
        textField1 = ""
        textField2 = ""
        textField3 = ""
        textField4 = ""
    }
    
    func isValidEmail() -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^[A-z0-9\.-]+@[A-z0-9\.-]+\.[A-z0-9]+"#)
        let range = NSRange(location: 0, length: textField1.count)
        return regexEmail.firstMatch(in: textField1, options: [], range: range) != nil
    }
    
    func isValidName() -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^[A-z0-9]+$"#)
        let range = NSRange(location: 0, length: textField3.count)
        return regexEmail.firstMatch(in: textField3, options: [], range: range) != nil
    }
    
    func isValidPass() -> Bool {
        let regexEmail = try! NSRegularExpression(pattern: #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"#)
        let range1 = NSRange(location: 0, length: textField2.count)
        return regexEmail.firstMatch(in: textField2, options: [], range: range1 ) != nil
    }
    
    @objc func timerTick() {
        if timeRemaining > 0 {
            errorMessageText = "Your email or password is wrong. Try again in \(timeRemaining)"
                    timeRemaining -= 1
                }
        else {
        timer?.invalidate()
        isButtonDisabled = false
        }
    }
    func startTimer() {
        if fails > 3 && fails % 4 == 0 {
            isAlertPresented.toggle()
        }
        if fails >= 3 {
            if fails == 3 {
                timeRemaining = 5
            }
            if fails > 3 {
                timeRemaining = 10
            }
            timerTime += 1
            isButtonDisabled = true
             timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
            return
            }
        isButtonDisabled = false
            return
    }
    
}
