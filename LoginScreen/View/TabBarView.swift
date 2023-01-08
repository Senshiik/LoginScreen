//
//  TabView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 16.10.2022.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject public var model: TabBarViewModel
    
    var body: some View {
        TabView {
            HomeView(homeViewModel: HomeViewModel())
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
                .onAppear {
                    NotificationCenter.default.post(name: .showOnBoarding, object: nil)
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(model: TabBarViewModel())
    }
}
