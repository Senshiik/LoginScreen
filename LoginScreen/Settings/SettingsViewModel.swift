//
//  Settings.swift
//  LoginScreen
//
//  Created by Anton Demkin on 19.10.2022.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published public var ispresented: Bool = false
    
    func isConfirmed() {
        ispresented.toggle()
    }
    func switchTab() {
        RootViewModel.shared.rootScreen = .login
    }
}
