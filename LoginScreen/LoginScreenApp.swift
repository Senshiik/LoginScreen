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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var model = LoginScreenModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL(perform: model.openUrl)
                .onAppear(perform: {
                    NetworkActivityLogger.shared.startLogging()
                    NetworkActivityLogger.shared.level = .debug
                })
        }
    }
}
