//
//  TextFieldCustom.swift
//  LoginScreen
//
//  Created by Anton Demkin on 07.08.2022.
//

import Foundation
import SwiftUI
struct TextFieldCustom: View {
    
    let title: String
    let text: Binding<String>
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self.text = text
    }
    
    var body: some View {
        TextField(title, text: text)
            .disableAutocorrection(true)
    }
}
