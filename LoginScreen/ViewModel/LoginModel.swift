//
//  LoginModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 06.08.2022.
//

import Foundation
import SwiftUI

class LoginModel: ObservableObject {

    @Published public var isRegistrationMode: Bool = false
    @Published public var isShowingSheet: Bool = false
    @Published public var isAlertPresented: Bool = false

    @Published public var isButtonDisabled: Bool = false
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var name: String = ""
    @Published public var passwordCheck: String = ""

    @Published public var errorMessageText: String = ""
    var validator = FieldValidator()
    private var isEmailValid: Bool = true
    private var isPassValid: Bool = true
    private var isPassEquals: Bool = true
    private var fails: Int = 0
    private var timeRemaining = 0
    private var timer: Timer?
    
    func mainButtonTap() {
        var isAllValid = true
        let validator = FieldValidator()
        
        if isRegistrationMode == true && !validator.isValidName(name: name){
            errorMessageText = "passwords must be equal"
            isAllValid = false
            return
        }
        
        if !validator.isValidEmail(email: email){
        errorMessageText = "Incorrect email"
            isAllValid = false
            return
        }
        if !validator.isValidPass(password: password){
            errorMessageText = "Incorrect password"
            isAllValid = false
            return
        }
        
        if isRegistrationMode == true && password != passwordCheck{
            errorMessageText = "passwords must be equal"
            isAllValid = false
            return
        }
        
        if isAllValid {
            errorMessageText = ""
        }
        
        if isAllValid && !LoginManager().tryLogin() {
            fails += 1
            startTimer()
        errorMessageText = ""
        }
    }

    func toggleSheet() {
        isShowingSheet.toggle()
    }
    
    func toggleRegistrationMode() {
        isRegistrationMode.toggle()
        fails = 0
        errorMessageText = ""
        name = ""
        passwordCheck = ""
        timer?.invalidate()
        
    }
    
    
    
    @objc func timerTick() {
        if timeRemaining > 0 {
            errorMessageText = "Your email or password is wrong. Try again in \(timeRemaining)"
            timeRemaining -= 1
        }
        else {
            timer?.invalidate()
            isButtonDisabled = false
            errorMessageText = ""
        }
    }

    private func startTimer() {
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
            isButtonDisabled = true
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
            return
        }
        isButtonDisabled = false
        return
    }
    
}
