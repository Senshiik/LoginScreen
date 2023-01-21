//
//  HomeView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 01.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject public var model: HomeViewModel
    @ObservedObject var user: ObservableUser
    
    var body: some View {
        
         ScrollView {
            VStack {
                Text("Name: \(user.name ?? "")")
            }
        }.refreshable(action: model.refresh)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let model = HomeViewModel(user: LoginManager.shared.currentUser)
        HomeView(model: model, user: model.user)
    }
}
