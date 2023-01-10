//
//  LoginScreenAppModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 09.01.2023.
//

import Foundation

class LoginScreenModel: ObservableObject {
    
    func openUrl(_ url: URL) {
        let url = url.absoluteString
        
        do {
            let urlRegex = try NSRegularExpression(pattern: #"https\:\/\/majordom\.parker\-programs\.com\/user\/verify\/(?<token>.+)"#)
            
            let match = urlRegex.firstMatch(in: url, options: [], range: NSRange(location: 0, length: url.count))!
            let matchRange = match.range(withName: "token")
            let substringRange = Range(matchRange, in: url)!
            let token = String(url[substringRange])
            Task {
                try await UserApiManager().verifyEmail(token: token)
            }
            print("token str: ", token)
            
        } catch {
            print("ERROR", error)
            return
        }
    }
}
