//
//  User.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.10.2022.
//

import Foundation
class User: Hashable, Equatable {
    
    let id = UUID()
    var username: String = ""
    var email: String = ""
    
    init(username: String, email: String) {
        self.username = username
        self.email = email

    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
}
