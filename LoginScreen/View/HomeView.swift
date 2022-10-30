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
            textView(text: LoginManager.shared.currentUser?.name ?? "name")
            textView(text: LoginManager.shared.currentUser?.email ?? "email")
            textView(text: LoginManager.shared.currentUser?.phone ?? "phone")
            textView(text: LoginManager.shared.currentUser?.lang ?? "lang")
            textView(text: dateConverter(date: LoginManager.shared.currentUser?.birthdate ?? Date()) )
            textView(text: LoginManager.shared.currentUser?.id.uuidString ?? "id")
        }
    }
    @ViewBuilder
    func textView(text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
    }
    func dateConverter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}
