//
//  PrimaryTextField.swift
//  LoginScreen
//
//  Created by Developer on 29.08.2022.
//

import SwiftUI

struct PrimaryTextField: View {
    
    public var isSecure: Bool = true
    @Binding var text: String
    public var title: String
    
    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding()
                .frame(height: 55)
                .background(Color("silver"))
                .font(.title2)
                .cornerRadius(10)
            
        }
    }
}
