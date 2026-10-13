//
//  StartScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct StartScreen: View
{
    @StateObject var navVM:NavigationViewModel = NavigationViewModel()
    @State private var showPrivacyScreen:Bool = true
    var authHandler: (AuthContext) -> Void
    var body: some View
    {
        if(showPrivacyScreen)
        {
            PrivacyStatement(showSelf: $showPrivacyScreen)
                .transition(.push(from: .trailing))
        } else
        {
            NavigationStack(path: $navVM.path)
            {
                VStack
                {
                    HStack
                    {
                        Text("In")
                            .font(.system(size: 75))
                            .bold()
                            .kerning(5)
                            .padding(-5)
                        Text("Bloom")
                            .font(.system(size: 75))
                            .bold()
                            .kerning(5)
                            .foregroundStyle(.green)
                    }
                    .padding(.top, 60)
                    Spacer()
                    Text("[picture here]")
                    Spacer()
                    VStack
                    {
                        Button("Sign Up")
                        {
                            navVM.pushScreen(screen: .signup)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonSizing(.flexible)
                        .font(.system(size: 30))
                        Button("Log In")
                        {
                            navVM.pushScreen(screen: .login)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonSizing(.flexible)
                        .font(.system(size: 30))
                    }
                    .tint(.green)
                    .padding(.horizontal, 40)
                }
                .padding()
                .navigationDestination(for: Screen.self)
                {(screen) in
                    switch screen
                    {
                    case .login:
                        LogInScreen(authHandler: authHandler)
                    case .signup:
                        SignUpScreen(authHandler: authHandler)
                    default:
                        self
                    }
                }
            }
            
        }
    }
}

#Preview
{
    StartScreen()
    {_ in
        
    }
}
