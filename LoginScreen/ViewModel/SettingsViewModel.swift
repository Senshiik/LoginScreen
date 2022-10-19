//
//  Settings.swift
//  LoginScreen
//
//  Created by Anton Demkin on 19.10.2022.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    func switchTab() {
        RootViewModel.shared.rootScreen = .login
    }
}
