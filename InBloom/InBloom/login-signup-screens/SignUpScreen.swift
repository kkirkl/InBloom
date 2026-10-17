//
//  SignUpScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/5/26.
//

import SwiftUI
import FirebaseAuth

let emailFormat:Regex = /(\w\.*)+\w+@\w+\.[a-zA-Z]{2,}/

struct SignUpScreen: View
{
    @ObservedObject var navVM:NavigationViewModel
    @Binding var authState:AuthContext
    @FocusState private var currentFocus:FieldType?
    
    @State private var emailField:String = ""
    @State private var emailErrorMessage:String = ""
    
    @State private var passwordField:String = ""
    @State private var isPasswordError:Bool = false
    @State private var hidePassword:Bool = true
    
    @State private var confirmPasswordField:String = ""
    @State private var confirmPasswordErrorMessage:String = ""
    @State private var hideConfirmPassword:Bool = true
    
    var isEmailError:Bool
    {
        !emailErrorMessage.isEmpty
    }
    var isConfirmPasswordError:Bool
    {
        !confirmPasswordErrorMessage.isEmpty
    }
    var isButtonDisabled:Bool
    {
        emailField.isEmpty || passwordField.isEmpty || confirmPasswordField.isEmpty
    }
    
    let firestoreMinPasswordLength:Int = 6
    let passwordMatchError:String = "Passwords must match"
    let passwordLengthError:String = "Password must be at least 6 characters long"
    let errorIcon:String = "exclamationmark.circle"
    let showPasswordIcon:String = "eye"
    let hidePasswordIcon:String = "eye.slash"
    let screenTitleFont:Font = .system(size: 28, weight: .bold)
    let buttonFont:Font = .system(size: 18, weight: .semibold)
    let subtitleFont:Font = .system(size: 16)
    let textFieldLabelFont:Font = .system(size: 14)
    let textFieldFont:Font = .system(size: 16)
    let textFieldPadding:CGFloat = 16
    let textFieldSpacing:CGFloat = 10
    let errorMessageSpacing:CGFloat = 3
    let rectCornerRadius:CGFloat = 12
    let rectBorderWidth:CGFloat = 1
    let rectBorderHighlightWidth:CGFloat = 2
    
    enum FieldType
    {
        case email
        case password
        case confirmPassword
    }
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack(alignment: .leading)
            {
                Text("Create your account!")
                    .font(screenTitleFont)
                    .foregroundStyle(.textPrimary)
                    .padding(.bottom, 6)
                Text("Just a few quick things to get started")
                    .font(subtitleFont)
                    .foregroundStyle(.textSecondary)
                    .padding(.bottom, 28)
                VStack(spacing: textFieldSpacing)
                {
                    VStack(alignment: .leading, spacing: errorMessageSpacing)
                    {
                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("Email")
                                .font(textFieldLabelFont)
                                .foregroundStyle(.textSecondary)
                            TextField("email field", text: $emailField, prompt: Text("Email address"))
                                .font(textFieldFont)
                                .textContentType(.emailAddress)
                                .foregroundStyle(.textPrimary)
                                .textInputAutocapitalization(.never)
                                .focused($currentFocus, equals: .email)
                        }
                        .padding(textFieldPadding)
                        .background
                        {
                            RoundedRectBackground(color: .backgroundSurface,
                                cornerRadius: rectCornerRadius,
                                borderColor: getBorderColor(hasError: isEmailError, type: .email),
                                borderWidth: getBorderWidth(hasError: isEmailError, type: .email))
                        }
                        .onTapGesture
                        {
                            currentFocus = .email
                        }
                        if(!emailErrorMessage.isEmpty)
                        {
                            HStack
                            {
                                Image(systemName: errorIcon)
                                Text(emailErrorMessage)
                                
                            }
                            .font(textFieldLabelFont)
                            .foregroundStyle(.stateError)
                            .padding(.leading, 6)
                        }
                    }
                    HStack
                    {
                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("Password")
                                .font(textFieldLabelFont)
                                .foregroundStyle(.textSecondary)
                            SecureTextField(text: $passwordField, isSecure: $hidePassword, title: "password field", prompt: Text("Password"))
                                .font(textFieldFont)
                                .textContentType(.newPassword)
                                .foregroundStyle(.textPrimary)
                                .focused($currentFocus, equals: .password)
                        }
                        Button
                        {
                            hidePassword.toggle()
                        } label:
                        {
                            Image(systemName: hidePassword ? showPasswordIcon : hidePasswordIcon)
                                .foregroundStyle(.textSecondary)
                        }
                    }
                    .padding(textFieldPadding)
                    .background
                    {
                        RoundedRectBackground(color: .backgroundSurface,
                            cornerRadius: rectCornerRadius,
                            borderColor: getBorderColor(hasError: isPasswordError, type: .password),
                            borderWidth: getBorderWidth(hasError: isPasswordError, type: .password))
                    }
                    .onTapGesture
                    {
                        currentFocus = .confirmPassword
                    }
                    VStack(alignment: .leading, spacing: errorMessageSpacing)
                    {
                        HStack
                        {
                            VStack(alignment: .leading, spacing: 2)
                            {
                                Text("Confirm password")
                                    .font(textFieldLabelFont)
                                    .foregroundStyle(.textSecondary)
                                SecureTextField(text: $confirmPasswordField, isSecure: $hideConfirmPassword, title: "confirm password field", prompt: Text("Confirm password"))
                                    .font(textFieldFont)
//                                    .textContentType(.newPassword)
                                    .foregroundStyle(.textPrimary)
                                    .focused($currentFocus, equals: .confirmPassword)
                            }
                            Button
                            {
                                hideConfirmPassword.toggle()
                            } label:
                            {
                                Image(systemName: hideConfirmPassword ? showPasswordIcon : hidePasswordIcon)
                                    .foregroundStyle(.textSecondary)
                            }
                        }
                        .padding(textFieldPadding)
                        .background
                        {
                            RoundedRectBackground(color: .backgroundSurface,
                                cornerRadius: rectCornerRadius,
                                borderColor: getBorderColor(hasError: isConfirmPasswordError,
                                                            type: .confirmPassword),
                                borderWidth: getBorderWidth(hasError: isConfirmPasswordError,
                                                            type: .confirmPassword))
                        }
                        .onTapGesture
                        {
                            currentFocus = .confirmPassword
                        }
                        if(!confirmPasswordErrorMessage.isEmpty)
                        {
                            HStack
                            {
                                Image(systemName: errorIcon)
                                Text(confirmPasswordErrorMessage)
                                
                            }
                            .font(textFieldLabelFont)
                            .foregroundStyle(.stateError)
                            .padding(.leading, 6)
                        }
                    }
                }
                Spacer()
                HStack
                {
                    Text("Already have an account?")
                        .foregroundStyle(.textSecondary)
                        .font(subtitleFont)
                    Button("Log in")
                    {
                        
                    }
                    .font(subtitleFont)
                    .fontWeight(.semibold)
                    .tint(.brandPrimary)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
                Button
                {
                    handleContinue()
                } label:
                {
                    Text("Continue")
                        .font(buttonFont)
                        .foregroundStyle(isButtonDisabled ? .textDisabled : .textOnPrimary)
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background
                        {
                            RoundedRectBackground(color: isButtonDisabled ?
                                                         .stateDisabled : .brandPrimary,
                                                  cornerRadius: 14)
                        }
                        
                }
                .disabled(isButtonDisabled)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(20)
            .ignoresSafeArea(.keyboard)
            .onSubmit(handleContinue)
        }
        .onTapGesture
        {
            currentFocus = nil
        }
    }
    
    func getBorderColor(hasError:Bool, type:FieldType) -> Color
    {
        if hasError
        {
            return .stateError
        }
        
        return currentFocus == type ? .brandPrimary : .borderDefault
    }
    
    func getBorderWidth(hasError:Bool, type:FieldType) -> CGFloat
    {
        if hasError
        {
            return rectBorderHighlightWidth
        }
        
        return currentFocus == type ? rectBorderHighlightWidth : rectBorderWidth
    }
    
    func handleContinue()
    {
        currentFocus = nil
        emailErrorMessage = ""
        isPasswordError = false
        confirmPasswordErrorMessage = ""
        do
        {
            if let match:Regex.Match = try emailFormat.wholeMatch(in: emailField)
            {
                
            } else
            {
                emailErrorMessage = "Invalid email"
            }
        } catch
        {
        }
        if passwordField != confirmPasswordField
        {
            confirmPasswordErrorMessage = passwordMatchError
        } else if passwordField.count < firestoreMinPasswordLength
        {
            isPasswordError = true
            confirmPasswordErrorMessage = passwordLengthError
        }
        if !isEmailError && !isPasswordError && !isConfirmPasswordError
        {
            navVM.pushScreen(screen: .confirmEmail(email: emailField))
        }
    }
}

#Preview
{
    @Previewable @StateObject var navVM:NavigationViewModel = NavigationViewModel()
    @Previewable @State var test:AuthContext = .unauthenticated
    SignUpScreen(navVM: navVM, authState: $test)
}
