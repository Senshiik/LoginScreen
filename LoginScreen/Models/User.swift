//
//  User.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.10.2022.
//

import Foundation
class User: Hashable, Equatable, Decodable {
    
    var email: String = ""
    var username: String? = ""
    var name: String? = ""
    var lang: String? = ""
    var country: String? = ""
    var birthdate: Date? = Date()
    var id = UUID()
    var isEmailVerified: Bool = true
    var is2faEnabled: Bool = true
    var registrationDate = Date()
    
    enum CodingKeys: String, CodingKey {
    case email
    case name
    case username
    case lang
    case country
    case birthdate
    case id
    case isEmailVerified = "is_email_verified"
    case is2faEnabled = "is_2fa_enabled"
    case registrationDate = "registration_date"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
}
