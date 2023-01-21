//
//  JSONDecoder.DateDecodingStrategy+iso8601withFractionalSeconds.swift
//  LoginScreen
//
//  Created by Anton Demkin on 08.01.2023.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date: " + string)
        }
        return date
    }
}
