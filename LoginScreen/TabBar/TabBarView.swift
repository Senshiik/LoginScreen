//
//  TabView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 16.10.2022.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject public var model: TabBarViewModel
    @ObservedObject public var loginManager = LoginManager.shared
    
    var body: some View {
        TabView {
            let model = HomeViewModel(user: loginManager.currentUser)
                HomeView(model: model, user: model.user)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            SettingsView(model: SettingsViewModel())
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
        .fullScreenCover(isPresented: $model.isOnBoarding) {
            OnBoardingView(model: OnBoardingViewModel())
        }
        .onAppear {
            Task {
                try await UserApiManager().getUser()
                }
            }
        }
    }

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(model: TabBarViewModel())
    }
}
