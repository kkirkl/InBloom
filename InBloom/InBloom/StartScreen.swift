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
    @State private var showPrivacyScreen:Bool = true // should be true unless testing
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
                        Button
                        {
                            temp()
                        } label:
                        {
                            Label()
                            {
                                Text("Continue with Google")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.textPrimary)
                            } icon:
                            {
                                Image(.googleIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                                    .padding(.trailing, 6)
                            }
                            .frame(width: 356, height: 52.5)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        .tint(.backgroundSurface)
                        .overlay
                        {
                            RoundedRectangle(cornerRadius: 18)
                                .strokeBorder(lineWidth: 2)
                                .foregroundStyle(.borderDefault)
                        }
                        Button
                        {
                            temp()
                        } label:
                        {
                            Label()
                            {
                                Text("Continue with Apple")
                                    .font(.system(size: 20, weight: .semibold))
                            } icon:
                            {
                                Image(systemName: "apple.logo")
                                    .font(.system(size: 30))
                            }
                            .foregroundStyle(.textPrimary)
                            .frame(width: 356, height: 52.5)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        .tint(.backgroundSurface)
                        .overlay
                        {
                            RoundedRectangle(cornerRadius: 18)
                                .strokeBorder(lineWidth: 2)
                                .foregroundStyle(.borderDefault)
                        }
                        Button
                        {
                            temp()
                        } label:
                        {
                            Label()
                            {
                                Text("Sign up with email")
                                    .font(.system(size: 20, weight: .semibold))
                            } icon:
                            {
                                Image(systemName: "envelope")
                                    .font(.system(size: 30))
                            }
                            .foregroundStyle(.textPrimary)
                            .frame(width: 356, height: 52.5)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        .tint(.backgroundSurface)
                        .overlay
                        {
                            RoundedRectangle(cornerRadius: 18)
                                .strokeBorder(lineWidth: 2)
                                .foregroundStyle(.borderDefault)
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
