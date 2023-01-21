//
//  TabBarModel.swift
//  LoginScreen
//
//  Created by Anton Demkin on 13.10.2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published public var isPresent: Bool = true
    @ObservedObject public var user: ObservableUser
    
    init(user: ObservableUser) {
        self.user = user
        }
   @Sendable
    func refresh() async {
        do {
            if let modelUser = try await UserApiManager().getUser() {
                print(user.name as Any)
                user.name = modelUser.name
                
            }
            
        } catch {
            print("Unknown error")
        }
        
    }
    
}
