//
//  SignUpScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/5/26.
//

import SwiftUI
import FirebaseAuth

let emailFormat:Regex = /\w+@\w+\.[a-zA-Z]{2,}/

struct SignUpScreen: View
{
    var authHandler: (AuthContext) -> Void
    @State private var emailField:String = ""
    @State private var passwordField:String = ""
    @State private var confirmPasswordField:String = ""
    @State private var statusText:String = ""
    var body: some View
    {
        VStack
        {
            Text("Create your account!")
                .font(.system(size: 50))
                .padding(.top, 50)
                .padding(.horizontal, 15)
                .padding(.bottom, 0)
                .multilineTextAlignment(.center)
            VStack
            {
                TextField("Email",
                          text: $emailField,
                          prompt: Text("\(Image(systemName: "envelope.fill"))Email"))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .font(.system(size: textFieldFont))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: textFieldCornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
                Spacer()
                SecureField("Password",
                          text: $passwordField,
                          prompt: Text(" \(Image(systemName: "lock.fill")) Password"))
                    .font(.system(size: textFieldFont))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: textFieldCornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
                Spacer()
                SecureField("Confirm Password",
                          text: $confirmPasswordField,
                          prompt: Text(" \(Image(systemName: "lock.fill")) Confirm password"))
                    .font(.system(size: textFieldFont))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: textFieldCornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
            }
            .onSubmit
            {
                handleSubmit()
            }
            .frame(height: 100)
            .padding()
            Text(statusText)
                .multilineTextAlignment(.center) //TODO style this
            Spacer()
            Button("Continue")
            {
                handleSubmit()
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .font(.system(size: 25))
            .tint(.green)
            .frame(width: 250)
            .padding(.bottom, 50)
            HStack
            {
                Text("Already have an account?")
                NavigationLink("Log in", destination: LogInScreen(authHandler: authHandler))
                    .underline()
            }
        }
        .padding(.horizontal, 15)
        .ignoresSafeArea(.keyboard)
    }
    
    func handleSubmit()
    {
        do
        {
            if let match:Regex.Match = try emailFormat.wholeMatch(in: emailField)
            {
                Auth.auth().createUser(withEmail: emailField, password: passwordField)
                {(result, error) in
                    if let error
                    {
                        statusText = error.localizedDescription
                    } else
                    {
                        statusText = "acount added!"
                    }
                }
            } else
            {
                statusText = "invalid email"
            }
        } catch
        {
            
        }
        
    }
}

#Preview
{
    SignUpScreen()
    {_ in
        
    }
}
