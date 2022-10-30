//
//  User.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.10.2022.
//

import Foundation
class User: Hashable, Equatable, Decodable {
    
    var id = UUID()
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var lang: String = ""
    var country: String = ""
    var birthdate = Date()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
}
