//
//  String+ToCamelCase.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.12.2022.
//

import Foundation

extension String {
    func toCamelCase() -> String {
        return self.lowercased()
            .split(separator: "_")
            .enumerated()
            .map { $0.offset > 0 ? $0.element.capitalized : $0.element.lowercased() }
            .joined()
    }
}
