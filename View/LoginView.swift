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
        VStack(spacing:16) {
                Spacer()
                Group {
                nameLabel
                nameField
                loginLabel
                loginField
                }
            Group{
                passLabel
                passwordField.alert("Forgot password?", isPresented: $model.isAlertPresented) {
                    Button("Try again", role: .cancel) {}
                    Button("reset the password") {
                        model.toggleSheet()
                        }
                    }
                secondPasswordField
                }
                Group {
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
                    Text("Incorrect password format!There must be at least: one digit, one upper letter one lower letter, length 8 or more")
                        .frame(alignment: .leading)
                        .foregroundColor(Color("salmon"))
                        .opacity( model.isPassValid ? 0.0 : 1)
                        .padding()}
                }
            Group {
            registerButton
            goToLogin
            }
            Spacer()
                logInButton.disabled(model.isButtonDisabled)
                    .opacity(model.isButtonDisabled ? 0.5 : 1.0)
                forgotPassButton
            registrationButton
                .opacity(model.isRegistrationMode ? 0.0 : 1.0)
            Group{
            Spacer()
            Spacer()
            }
        }.padding()
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
                    self.model.textField3 = ""})
                       {
                    Image(systemName: "delete.left")                               .opacity(model.isRegistrationMode ? 1.0 : 0.0)
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
    
    private var loginField: some View {
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
            .opacity(model.isRegistrationMode ? 1.0 : 0.0)
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
    
    private var logInButton: some View {
        PrimaryButton(text: "Log in",
                      style: .primary,
                      action: model.logIn)
        .opacity(model.isRegistrationMode ? 0.0 : 1.0)
        .sheet(isPresented: $model.isValid) {
            Text("You entered your account")
        }
    }
    private var registrationButton: some View {
        PrimaryButton(text: "Don`t have an account yet?",
                      style: .primary,
                      filled: false,
                      action: model.toggleRegistrationMode)
        .lineLimit(2)
        }
    
    private var registerButton: some View {
        PrimaryButton(text: "Register",
                      style: .primary,
                      filled: false,
                      action: model.register1)
        .opacity(model.isRegistrationMode ? 1.0 : 0.0)
    }
    
    private var goToLogin: some View {
        PrimaryButton(text: "Already have an account?",
                      style: .primary,
                      filled: false,
                      action: model.toggleRegistrationMode)
        .opacity(model.isRegistrationMode ? 1.0 : 0.0)
        
    }
    
    private var forgotPassButton: some View {
        PrimaryButton(text: "Forgot password?",
                      style: .danger,
                      filled: false,
                      action: model.toggleSheet)
        .opacity(model.isRegistrationMode ? 0.0 : 1.0)
        .sheet(isPresented: $model.isPressed) {
            SafariView(url: URL(string: "https://support.google.com/accounts/answer/41078?hl=en&co=GENIE.Platform%3DAndroid")!)
        }
    }
}
