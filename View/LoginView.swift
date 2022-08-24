//
//  LoginView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.08.2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject public var model: LoginModel
    
    var body: some View {
            VStack {
                Spacer()
                loginLabel
                loginField
                passLabel
                passwordField.alert("Forgot password?", isPresented: $model.isAlertPresented) {
                    Button("Try again", role: .cancel) {}
                    Button("reset the password") {
                        model.toggleSheet()
                    }
                }
                if model.isButtonDisabled {
                    Text(model.errorMessageText)
                        .padding(16)
                        .foregroundColor(Color("salmon"))
                    
                }
                if model.isShowingError {
                    Text("Incorrect email format")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("salmon"))
                        .opacity( model.isEmailValid ? 0.0 : 1)
                        .padding()
                    Text("Incorrect password format!There must be at least: one digit, one upper letter one lower letter, length 8 or more")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("salmon"))
                        .opacity( model.isPassValid ? 0.0 : 1)
                        .padding()
                    
                }
                Spacer()
                logInButton.disabled(model.isButtonDisabled)
                    .opacity(model.isButtonDisabled ? 0.5 : 1.0)
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
                .preferredColorScheme(.dark)
        }

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
