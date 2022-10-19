//
//  SettingsView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 19.10.2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
        Spacer()
            PrimaryButton(text: "Log out", style: .primary, filled: false, action: SettingsViewModel().switchTab)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
