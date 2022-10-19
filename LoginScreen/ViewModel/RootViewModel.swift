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
        
    }
    enum Screen {
        case tabBar
        case login
    }
    
    @Published var rootScreen: Screen = .login
    
}
