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
        VStack(spacing: 16) {
            Spacer()
            Group {
                if model.isRegistrationMode {
                    nameLabel
                    nameField
                }
                loginField
            }
            Group {
                passLabel
                passwordField
                if model.isRegistrationMode {
                    secondPasswordField
                }
            }
            Text(model.errorMessageText)
                .padding(16)
                .foregroundColor(.salmon)
            Group {
                if model.isRegistrationMode {
                    registerButton
                    goToLogin
                }
            }
            Spacer()
            if !model.isRegistrationMode {
                logInButton
                    .disabled(model.isButtonDisabled)
                forgotPassButton
                registrationButton
            }
        }
        .padding()
        //.background(Color.background.ignoresSafeArea())
        .sheet(isPresented: $model.isShowingSheet) {
            SafariView(url: URL(string: "https://support.google.com/accounts/answer/41078?hl=en&co=GENIE.Platform%3DAndroid")!)
        }
        .alert("Forgot password?", isPresented: $model.isAlertPresented) {
            Button("Try again", role: .cancel) {}
            Button("reset the password", action: model.toggleSheet)
        }
    }
}

// MARK: - Subviews

extension LoginView {
    
    private var passLabel: some View {
        Text("Password")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var nameLabel: some View {
        Text("Name")
            .opacity(model.isRegistrationMode ? 1.0 : 0.0)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var nameField: some View {
        TextField("Type your name here", text: $model.textField3)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding()
            .frame(height:55)
            .background(Color("silver"))
            .font(.title2)
            .cornerRadius(10)
            .opacity(model.isRegistrationMode ? 1.0 : 0.0)
            .overlay(alignment: .trailing, content: {
                Button(action: {
                    self.model.textField3 = ""
                }){
                    Image(systemName: "delete.left")
                        .opacity(model.isRegistrationMode ? 1.0 : 0.0)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            })
    }
    private var loginLabel: some View {
        Text(model.isRegistrationMode ? "Email" : "Login")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var loginField: some View {
        loginLabel
        TextField("Type your email here", text: $model.textField1)
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
        SecureField("Type your password here", text: $model.textField2)
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
    
    private var secondPasswordField: some View {
        SecureField("Type your password again", text: $model.textField4)
            .disableAutocorrection(true)
            .padding()
            .font(.title2)
            .frame(height:55)
            .background(Color("silver"))
            .cornerRadius(10)
            .overlay(alignment: .trailing, content: {
                Button(action: {
                    self.model.textField4 = ""})
                {
                    Image(systemName: "delete.left")
                        .opacity(model.isRegistrationMode ? 1.0 : 0.0)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
            })
    }

    // TODO: primary button
    private var logInButton: some View {
        PrimaryButton(text: "Log in",
                      style: .primary,
                      action: model.logIn)
    }
    
    private var registerButton: some View {
        PrimaryButton(text: "Register",
                      style: .primary,
                      action: model.register)
    }

    // TODO: secondary button
    private var registrationButton: some View {
        PrimaryButton(text: "Don`t have an account yet?",
                      style: .primary,
                      filled: false,
                      action: model.toggleRegistrationMode)
    }
    
    private var goToLogin: some View {
        PrimaryButton(text: "Already have an account?",
                      style: .primary,
                      filled: false,
                      action: model.toggleRegistrationMode)
    }
    
    private var forgotPassButton: some View {
        PrimaryButton(text: "Forgot password?",
                      style: .danger,
                      filled: false,
                      action: model.toggleSheet)
    }
}

// MARK: - Previews

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView(model: LoginModel())
                .preferredColorScheme(.dark)
        }

    }
}
