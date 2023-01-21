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
    private var timer: Timer?
    @Published var timeRemaining: Int = 0
    
    func resendVerification() {
        startTimer()
        Task {
            try? await UserApiManager().resendVerification()
        }
    }
    
    @objc func timerTick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isButtonDisabled = false
            timer?.invalidate()
        }
    }
    
    private func startTimer() {
        timeRemaining = 15
        isButtonDisabled = true
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerTick),
            userInfo: nil,
            repeats: true)
    }
}
