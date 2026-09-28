//
//  ContentView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 9/28/26.
//

import SwiftUI

struct ContentView: View
{
    var body: some View
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
                Button("Sign up")
                {
                    
                }
                .buttonStyle(.borderedProminent)
                .buttonSizing(.flexible)
                .font(.system(size: 30))
                Button("Log in")
                {
                    
                }
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

#Preview
{
    ContentView()
}
