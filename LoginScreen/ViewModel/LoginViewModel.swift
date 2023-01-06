//
//  LoginModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 06.08.2022.
//

import Foundation
import SwiftUI
import Alamofire

class LoginViewModel: ObservableObject, TotpViewModelDelegate {
    
    func didEnterCode(code: String) {
        isTotpMissed = false
        syncTryLogReg(code: code)
        print("delegate", code)
    }
    
    @Published public var isRegistrationMode: Bool = false
    @Published public var isShowingSheet: Bool = false
    @Published public var isAlertPresented: Bool = false
    @Published public var isTotpMissed: Bool = false
    @Published public var isButtonDisabled: Bool = false
    @Published public var email: String = ""
    @Published public var password: String = ""
    @Published public var username: String = ""
    @Published public var passwordCheck: String = ""
    @Published public var messageText: String = ""
    @Published public var timeRemainingText: String = ""
    
    var validator = FieldValidator()
    private var isEmailValid: Bool = true
    private var isPassValid: Bool = true
    private var isPassEquals: Bool = true
    private var fails: Int = 0
    private var timeRemaining = 0
    private var timer: Timer?
    
    func mainButtonTap() {
        var isAllValid = true
        
        if isRegistrationMode && !validator.isValidName(username: username) {
            messageText = "Incorrect name"
            isAllValid = false  
        }
        
        if !validator.isValidEmail(email: email) {
            if isAllValid {
                messageText = "Incorrect email"
                isAllValid = false
            }
        }
        
        if !validator.isValidPass(password: password) {
            if isAllValid {
                messageText = "Incorrect password"
                isAllValid = false
            }
        }
        
        if isRegistrationMode == true && password != passwordCheck {
            if isAllValid {
                messageText = "Passwords must be equal"
                isAllValid = false
            }
        }
        
        if isAllValid {
            messageText = ""
            syncTryLogReg()
        } else {
            fails += 1
            startTimer()
            messageText = ""
        }
    }
    func syncTryLogReg(code: String? = nil) {
        print(#function, code)
        Task(priority: .high) {
            if isRegistrationMode {
                do {
                    try await LoginManager.shared.tryRegister(username: username, email: email, password: password)
                    DispatchQueue.main.async {
                        RootViewModel.shared.rootScreen = .tabBar
                    }
                } catch {
                    await handleErrors(error: error)
                }
            } else {
                do {
                    try await LoginManager.shared.tryLogin(email: email, password: password, code: code)
                    DispatchQueue.main.async {
                        RootViewModel.shared.rootScreen = .tabBar
                    }
                } catch {
                    await handleErrors(error: error)
                    
                }
            }
        }
    }
    func toggleSheet() {
        isShowingSheet.toggle()
    }
    
    func toggleTotp() {
        isTotpMissed.toggle()
    }
    
    func toggleRegistrationMode() {
        isRegistrationMode.toggle()
        fails = 0
        messageText = ""
        username = ""
        passwordCheck = ""
        timer?.invalidate()
        
    }
    
    @objc func timerTick() {
        if timeRemaining > 0 {
            messageText = "Your email or password is wrong. Try again in \(timeRemaining)"
            timeRemaining -= 1
        } else {
            timer?.invalidate()
            isButtonDisabled = false
            messageText = ""
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
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(timerTick),
                userInfo: nil,
                repeats: true)
            return
        }
        isButtonDisabled = false
        return
    }
    func handleErrors(error: Error) async {
        switch error as? LoginError {
        case .totpMissed:
            DispatchQueue.main.async {
                self.isTotpMissed.toggle()
            }
        case .totpInvalid:
            print("totpInvalid")
        case .emailNotVerified:
            print("email not verified")
        case .none:
            print("Unexpected error")
        case .tokenExpired:
            print("Token expired")
        case .invalidToken:
            print("Invalid token")
        case .unexpectedError:
            print("Unexpected error")
        }
    }
}
