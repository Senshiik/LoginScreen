//
//  ObservableUser.swift
//  LoginScreen
//
//  Created by Anton Demkin on 10.01.2023.
//

import Foundation

class ObservableUser: ObservableObject {
    
    @Published public var email: String = ""
    @Published public var username: String?
    @Published public var name: String?
    @Published public var lang: String?
    @Published public var country: String?
    @Published public var birthdate: Date?
    @Published public var id = UUID()
    @Published public var isEmailVerified: Bool = true
    @Published public var is2faEnabled: Bool = true
    @Published public var registrationDate = Date()

    init(_ user: User) {
        self.email = user.email
        self.username = user.username
        self.name = user.name
        self.lang = user.lang
        self.country = user.country
        self.birthdate = user.birthdate
        self.id = user.id
        self.isEmailVerified = user.isEmailVerified
        self.is2faEnabled = user.is2faEnabled
        self.registrationDate = user.registrationDate
        
    }
}
