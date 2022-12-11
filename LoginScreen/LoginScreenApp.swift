//
//  LoginScreenApp.swift
//  LoginScreen
//
//  Created by Anton Demkin on 04.08.2022.
//

import SwiftUI
import AlamofireNetworkActivityLogger

@main
struct LoginScreenApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
//            .onAppear(perform: {
//                NetworkActivityLogger.shared.startLogging()
//                NetworkActivityLogger.shared.level = .debug
                
            //})
        }
    }
}
