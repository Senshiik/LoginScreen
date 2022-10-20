//
//  RootView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 01.10.2022.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject private var model = RootViewModel.shared
    
    var body: some View {
        switch model.rootScreen {
        case.login: LoginView(model: LoginModel())
        case.tabBar: TabBarView()
        case.fullScreenCover: EmailVerificationView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
    }
}
