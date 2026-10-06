//
//  StartScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct StartScreen: View
{
    var authHandler: (AuthContext) -> Void
    var body: some View
    {
        NavigationStack
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
                    NavigationLink("Sign Up", destination: SignUpScreen(authHandler: authHandler))
                        .buttonStyle(.borderedProminent)
                        .buttonSizing(.flexible)
                        .font(.system(size: 30))
                    NavigationLink("Log In", destination: LogInScreen(authHandler: authHandler))
                        .buttonStyle(.borderedProminent)
                        .buttonSizing(.flexible)
                        .font(.system(size: 30))
                }
                .tint(.green)
                .padding(.horizontal, 40)
            }
            .padding()
        }
    }
}

#Preview
{
    StartScreen()
    {_ in
        
    }
}
