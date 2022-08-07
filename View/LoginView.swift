//
//  LoginView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.08.2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject public var model:LoginModel
    @State var textField1: String = ""
    @State var textField2: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Login")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            loginField
            Text("Password")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            passwordField
            Spacer()
            logInButton
            forgotPassButton
        }
        .padding()
        .background(Color.background.ignoresSafeArea())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView(model: LoginModel())

        }
        .preferredColorScheme(.dark)
    }
}

extension LoginView {
    private var loginField: some View {
        TextField("Type your email here...", text: $textField1)
            .padding()
            .frame(height:55)
            .background(Color("silver"))
            .font(.title2)
            .cornerRadius(10)
    }
    
    private var passwordField: some View {
        TextField("Type your password here...", text: $textField2)
            .padding()
            .font(.title2)
            .frame(height:55)
            .background(Color("silver"))
            .cornerRadius(10)
    }
    private var logInButton: some View {
        PrimaryButton(text: "Log in",
                      style: .primary,
                      action: model.logIn)
    }
    private var forgotPassButton: some View {
        PrimaryButton(text: "Forgot password?",
                      style: .danger,
                      filled: false,
                      action:model.logIn)
    }
}
