//
//  LoginView.swift
//  LoginScreen
//
//  Created by Anton Demkin on 05.08.2022.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject public var model: LoginViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            if model.isRegistrationMode {
                nameField
            }
            
            loginField
            passwordField
            
            if model.isRegistrationMode {
                secondPasswordField
            }
            Text(model.messageText)
                .padding(16)
                .foregroundColor(.salmon)
            Spacer()
            
            mainButton
                .disabled(model.isButtonDisabled)
            
            forgotPassButton
            toggleModeButton
            
        }
        .padding()
        .background(Color.background.ignoresSafeArea())
        .ignoresSafeArea()
        .sheet(isPresented: $model.isShowingSheet) {
            SafariView(url: URL(string: "https://support.google.com/accounts/answer/41078?hl=en&co=GENIE.Platform%3DAndroid")!)
        }
        .sheet(isPresented: $model.isTotpMissed) {
            TotpTextFieldView(model: TotpViewModel(delegate: model))
            Button("Submit", role: .cancel, action: model.syncTryLogReg)
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
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var loginLabel: some View {
        Text("Username or Email")
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var nameField: some View {
        nameLabel
        PrimaryTextField(isSecure: false,
                         text: $model.username,
                         title: "Type your name here")
        .overlay(alignment: .trailing, content: {
            Button(action: {
                self.model.username = ""
            }) {
                Image(systemName: "delete.left")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        })
    }
    
    @ViewBuilder
    private var loginField: some View {
        loginLabel
        PrimaryTextField(isSecure: false,
                         text: $model.email,
                         title: "Type your email here...")
        .overlay(alignment: .trailing, content: {
            Button(action: {
                self.model.email = ""}) {
                    Image(systemName: "delete.left")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
        })
    }
    @ViewBuilder
    private var passwordField: some View {
        passLabel
        PrimaryTextField(
            isSecure: true,
            text: $model.password,
            title: "Type your password here..."
        )
        .overlay(alignment: .trailing, content: {
            Button(action: {
                self.model.password = ""}) {
                    Image(systemName: "delete.left")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
        })
    }
    
    private var secondPasswordField: some View {
        PrimaryTextField(
            isSecure: true,
            text: $model.passwordCheck,
            title: "Type your password again"
        )
        .overlay(alignment: .trailing, content: {
            Button(action: {
                self.model.passwordCheck = ""}) {
                    Image(systemName: "delete.left")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
        })
    }
    
    private var mainButton: some View {
        PrimaryButton(text: !model.isRegistrationMode ? "Log in" : "Register",
                      style: .primary,
                      action: model.mainButtonTap)
    }
    
    private var toggleModeButton: some View {
        PrimaryButton(text: !model.isRegistrationMode ? "Don`t have an account yet?" : "Already have an account?",
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
        NavigationView {
            LoginView(model: LoginViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
