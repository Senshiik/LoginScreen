//
//  LoginView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.08.2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject public var model: LoginModel
    var k: Int = 0
    
    var body: some View {
            VStack {
                Spacer()
                loginLabel
                loginField
                passLabel
                passwordField
                if model.isShowingError {
                    Text("Your email or password is wrong!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("salmon"))
                    
                }
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
    
    private var passLabel: some View {
        Text("Password")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var loginLabel: some View {
        Text("Login")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var loginField: some View {
        TextField("Type your email here...", text: $model.textField1)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding()
            .frame(height:55)
            .background(Color("silver"))
            .font(.title2)
            .cornerRadius(10)
            .overlay(alignment: .trailing, content: {
                Button(action: {
                    self.model.textField1 = ""})
                       {
                    Image(systemName: "delete.left")
                               .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            })
    }
    
    private var passwordField: some View {
        SecureField("Type your password here...", text: $model.textField2)
            .disableAutocorrection(true)
            .padding()
            .font(.title2)
            .frame(height:55)
            .background(Color("silver"))
            .cornerRadius(10)
            .overlay(alignment: .trailing, content: {
                Button(action: {
                    self.model.textField2 = ""})
                       {
                    Image(systemName: "delete.left")
                               .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            })
    }
    private var logInButton: some View {
        PrimaryButton(text: "Log in",
                      style: .primary,
                      action: model.logIn)
        .sheet(isPresented: $model.isValid) {
            Text("You entered your account")
        }
    }
    private var forgotPassButton: some View {
        PrimaryButton(text: "Forgot password?",
                      style: .danger,
                      filled: false,
                      action: model.toggleSheet)
        .sheet(isPresented: $model.isPressed) {
            SafariView(url: URL(string: "https://support.google.com/accounts/answer/41078?hl=en&co=GENIE.Platform%3DAndroid")!)
        }
    }
}
