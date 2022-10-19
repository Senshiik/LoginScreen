//
//  TabBarView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 01.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject public var homeViewModel: HomeViewModel

    var body: some View {
        VStack {
            Text(LoginManager.shared.currentUser?.username ?? "Username")
            .font(.subheadline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            Text(LoginManager.shared.currentUser?.email ?? "Email")
            .font(.subheadline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
        }
        .alert("You are in your account now", isPresented: $homeViewModel.isPresent) {
            Button("Ok", role: .cancel) {}
             }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
