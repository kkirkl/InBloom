//
//  StartScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct StartScreen: View
{
    let buttonWidth:CGFloat = 380
    
    @StateObject var navVM:NavigationViewModel = NavigationViewModel()
    @State private var showPrivacyScreen:Bool = true
    @Binding var authState:AuthContext
    
    var body: some View
    {
        if(showPrivacyScreen)
        {
            PrivacyStatement(showSelf: $showPrivacyScreen)
                .transition(.push(from: .top))
        } else
        {
            ZStack
            {
                Color(.backgroundDefault)
                    .ignoresSafeArea()
                VStack(spacing: 20)
                {
                    Spacer()
                    Spacer()
                    VStack
                    {
                        Text("InBloom")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(.textPrimary)
                            .padding(.bottom, 2)
                        Text("Plant your progress!")
                            .font(.system(size: 18))
                            .foregroundStyle(.textSecondary)
                    }
                    Image(.plantBloom)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 268)
                        .padding(.bottom, 20)
                    VStack(alignment: .center, spacing: 18)
                    {
                        Button(action: loginGoogle)
                        {
                            Image(.googleIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .padding(.trailing, 6)
                            Text("Continue with Google")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .frame(width: buttonWidth, height: 66)
                        .tint(.textPrimary)
                        .background
                        {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(.backgroundSurface)
                                .overlay
                                {
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundStyle(.borderDefault)
                                }
                            
                        }
                        Button(action: loginApple)
                        {
                            HStack
                            {
                                Image(systemName: "apple.logo")
                                    .font(.system(size: 30))
                                    .padding(.trailing, 6)
                                Text("Continue with Apple")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                        .frame(width: buttonWidth, height: 66)
                        .tint(.textPrimary)
                        .background
                        {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(.backgroundSurface)
                                .overlay
                                {
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundStyle(.borderDefault)
                                }
                            
                        }
                        Button(action: loginEmail)
                        {
                            HStack
                            {
                                Image(systemName: "envelope")
                                    .font(.system(size: 26))
                                    .padding(.trailing, 6)
                                Text("Sign up with email")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                        .frame(width: buttonWidth, height: 66)
                        .tint(.textPrimary)
                        .background
                        {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(.backgroundSurface)
                                .overlay
                                {
                                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                                        .strokeBorder(lineWidth: 2)
                                        .foregroundStyle(.borderDefault)
                                }
                            
                        }
                        HStack
                        {
                            Text("Already have an account?")
                                .foregroundStyle(.textSecondary)
                                .font(.system(size: 20))
                            Button("Log in")
                            {
                                
                            }
                            .font(.system(size: 20, weight: .semibold))
                            .tint(.brandPrimary)
                        }
                        .padding(.top, 15)
                    }
                    Spacer()
                    Button("Privacy statement")
                    {
                        withAnimation
                        {
                            showPrivacyScreen = true
                        }
                    }
                    .tint(.textSecondary)
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    func loginGoogle()
    {
        temp()
    }
    
    func loginApple()
    {
        temp()
    }
    
    func loginEmail()
    {
        temp()
    }
    
    func temp()
    {
        withAnimation
        {
            authState = .authenticated
        }
    }
}

#Preview
{
    @Previewable @State var auth:AuthContext = .unauthenticated
    StartScreen(authState: $auth)
}
