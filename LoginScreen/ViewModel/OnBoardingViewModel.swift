//
//  OnBoardingViewModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 07.01.2023.
//

import Foundation

class OnBoardingViewModel: ObservableObject {
    
    @Published public var isButtonDisabled: Bool = false
    private var fails: Int = 0
    private var timeRemaining: Int = 0
    private var timer: Timer?
    
    func resendVerification() {
        Task {
            startTimer()
            try? await UserApiManager().resendVerification()
        }
        
    }
    
    @objc func timerTick() {
        timeRemaining = 10
        if timeRemaining > 0 {
            timeRemaining -= 1
            isButtonDisabled = true
        } else {
            isButtonDisabled = false
            timer?.invalidate()
            
        }
    }
    
    private func startTimer() {
        
            timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(timerTick),
                userInfo: nil,
                repeats: true)
        isButtonDisabled = false
            return
        }
}
