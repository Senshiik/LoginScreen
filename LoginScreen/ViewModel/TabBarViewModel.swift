//
//  TabBarViewModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 08.01.2023.
//

import Foundation

class TabBarViewModel: ObservableObject {
    
    @Published public var isOnBoarding: Bool = false
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(showOnBoarding), name: .showOnBoarding, object: nil)
    }
    
    @objc func showOnBoarding() {
        isOnBoarding = true
    }
}
