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
    @ObservedObject var navVM:NavigationViewModel
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var username:String = ""
    @State private var university:String = ""
    
    let buttonFont:Font = .system(size: 18, weight: .semibold)
    let buttonCornerRadius:CGFloat = 14
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack
            {
                Spacer()
                Image(systemName: "questionmark.square.dashed")
                    .foregroundStyle(.brandPrimary)
                    .font(.system(size: 120))
                Text("under construction :)")
                    .foregroundStyle(.textSecondary)
                Spacer()
                Button
                {
                    withAnimation
                    {
                        authState = .authenticated
                    }
                } label:
                {
                    Text("Continue")
                        .font(buttonFont)
                        .foregroundStyle(.textOnPrimary)
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background
                        {
                            RoundedRectBackground(color: .brandPrimary,
                                                  cornerRadius: buttonCornerRadius)
                        }
                        
                }
            }
            .padding(20)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview
{
    @Previewable @State var test:AuthContext = .unauthenticated
    @Previewable @StateObject var navVM:NavigationViewModel = NavigationViewModel()
    CreateProfileScreen(authState: $test, navVM: navVM)
}
