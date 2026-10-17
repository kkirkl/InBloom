//
//  EmailConfirmed.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

struct EmailConfirmed: View
{
    @Binding var authState:AuthContext
    @ObservedObject var navVM:NavigationViewModel
    let screenTitleFont:Font = .system(size: 28, weight: .bold)
    let subtitleFont:Font = .system(size: 16)
    let buttonFont:Font = .system(size: 18, weight: .semibold)
    let buttonCornerRadius:CGFloat = 14
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack(spacing: 14)
            {
                Spacer()
                Image(systemName: "checkmark")
                    .font(.system(size: 56, weight: .semibold))
                    .foregroundStyle(.brandPrimary)
                    .padding(36)
                    .background
                    {
                        Circle()
                            .fill(.brandPrimaryLight)
                    }
                Text("Email confirmed!")
                    .font(screenTitleFont)
                    .foregroundStyle(.textPrimary)
                Text("Just some quick personalization next")
                    .font(subtitleFont)
                    .foregroundStyle(.textSecondary)
                Spacer()
                Button
                {
                    navVM.pushScreen(screen: .createProfile)
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
            .navigationBarBackButtonHidden()
            .padding(20)
        }
    }
}

#Preview
{
    @Previewable @State var test:AuthContext = .unauthenticated
    @Previewable @StateObject var navVM:NavigationViewModel = NavigationViewModel()
    EmailConfirmed(authState: $test, navVM: navVM)
}
