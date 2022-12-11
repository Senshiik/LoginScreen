//
//  RootViewModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 01.10.2022.
//

import Foundation
import SwiftUI

class RootViewModel: ObservableObject {
    
    static let shared = RootViewModel()
    private init() {

        if TokenManager.shared.isLoggedIn() {
            Task {
                await UserApiManager().refresh()
            }
            rootScreen = .tabBar
        } else {
            rootScreen = .login
        }
        
    }
    enum Screen {
        case tabBar
        case login
        case fullScreenCover
    }
    
    @Published var rootScreen: Screen = .login
    
}
