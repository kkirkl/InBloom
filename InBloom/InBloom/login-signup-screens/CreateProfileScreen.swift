//
//  CreateProfileScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct CreateProfileScreen: View
{
    @Binding var authState:AuthContext
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var username:String = ""
    @State private var university:String = ""
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack
            {
                
            }
            .padding(20)
        }
    }
}

#Preview
{
    @Previewable @State var test:AuthContext = .unauthenticated
    CreateProfileScreen(authState: $test)
}
