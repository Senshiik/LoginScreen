//
//  RootView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 01.10.2022.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject private var model = RootViewModel.shared
    @StateObject private var tabBarVM = TabBarViewModel()
    
    var body: some View {
        switch model.rootScreen {
        case .login: LoginView(model: LoginViewModel())
        case .tabBar: TabBarView(model: tabBarVM)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
    }
}
