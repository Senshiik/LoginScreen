//
//  OnBoardingView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 07.01.2023.
//

import SwiftUI

struct OnBoardingView: View {
    
    @StateObject public var model: OnBoardingViewModel
    
    var body: some View {
        PrimaryButton(text: "Send email verification again", style: .primary, action: model.resendVerification).disabled(model.isButtonDisabled)
        if model.timeRemaining > 0 {
            Text("Send verification again in \(model.timeRemaining)")
        }
        PrimaryButton(text: "Log Out", style: .danger, action: LoginManager.shared.logOut)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(model: OnBoardingViewModel())
    }
}
