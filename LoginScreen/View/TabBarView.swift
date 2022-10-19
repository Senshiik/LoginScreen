//
//  TabView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 16.10.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView(homeViewModel: HomeViewModel())
                .tabItem {
                Label("Home", systemImage: "house.fill")
                         }
            SettingsView()
                .tabItem {
                        Label("Settings", systemImage: "slider.horizontal.3")
                         }
                }
        }
    }
struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .preferredColorScheme(.dark)
    }
}
