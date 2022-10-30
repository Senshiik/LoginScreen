//
//  TokensPair.swift
//  LoginScreen
//
//  Created by Anton Demkin on 30.10.2022.
//

import Foundation
import Alamofire

struct TokensPair: Decodable {
    
    var accessToken: String = ""
    var refreshToken: String = ""
    
    enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    }
    
}
