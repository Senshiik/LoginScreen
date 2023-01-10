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
        textField
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding()
            .frame(height: 55)
            .background(Color("silver"))
            .font(.title2)
            .cornerRadius(10)
    }
    
    @ViewBuilder
    private var textField: some View {
        if isSecure {
            SecureField(title, text: $text)
                .foregroundColor(Color.black)
        } else {
            TextField(title, text: $text)
        }
    }
}
