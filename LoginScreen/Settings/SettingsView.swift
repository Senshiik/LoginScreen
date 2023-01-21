//
//  SettingsView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 19.10.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject public var model: SettingsViewModel
    
    var body: some View {
        VStack {
        Spacer()
            PrimaryButton(text: "Log out", style: .primary, filled: false, action: LoginManager.shared.logOut)
            PrimaryButton(text: "Delete account", style: .danger, filled: false, action: model.isConfirmed)
        }.alert("Are you sure?", isPresented: $model.ispresented) {
            Button("Delete", action: LoginManager.shared.delete)
            Button("No", role: .cancel) {}
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(model: SettingsViewModel())
            .preferredColorScheme(.dark)
    }
}
