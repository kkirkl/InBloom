//
//  LogInScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 9/28/26.
//

import SwiftUI

let textFieldFont:CGFloat = 25
let textFieldCornerRadius:CGFloat = 5

struct LogInScreen: View
{
    var authHandler: (AuthContext) -> Void
    @State private var emailFieldText:String = ""
    @State private var passwordFieldText:String = ""
    var body: some View
    {
        VStack
        {
            Text("Log into your\naccount!")
                .font(.system(size: 50))
                .padding(.top, 50)
                .padding(.horizontal, 15)
                .padding(.bottom, 0)
                .multilineTextAlignment(.center)
            VStack
            {
                TextField("Email",
                          text: $emailFieldText,
                          prompt: Text("\(Image(systemName: "envelope.fill"))Email"))
                    .font(.system(size: textFieldFont))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: textFieldCornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
                Spacer()
                SecureField("Password",
                          text: $passwordFieldText,
                          prompt: Text(" \(Image(systemName: "lock.fill")) Password"))
                    .font(.system(size: textFieldFont))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: textFieldCornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
            }
            .frame(height: 100)
            .padding()
            Spacer()
            Button("Continue")
            {
                withAnimation
                {
                    authHandler(.authenticated)
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .font(.system(size: 25))
            .tint(.green)
            .frame(width: 250)
            .padding(.bottom, 50)
        }
        .padding(.horizontal, 15)
    }
}

#Preview
{
    LogInScreen()
    {_ in
        
    }
}
