//
//  ContentView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 9/28/26.
//

import SwiftUI

enum AuthContext
{
    case unauthenticated
    case authenticated
}



struct ContentView: View
{
    @State private var authenticationStatus:AuthContext = .unauthenticated
    var body: some View
    {
        switch authenticationStatus
        {
            case .unauthenticated:
                StartScreen()
                {(authStatus) in
                    self.authenticationStatus = authStatus
                }
                .transition(.push(from: .bottom))
                
            case .authenticated:
                MainView()
        }
    }
}

#Preview
{
    ContentView()
}
