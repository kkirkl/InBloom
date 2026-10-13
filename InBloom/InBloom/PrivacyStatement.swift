//
//  PrivacyStatement.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/13/26.
//

import SwiftUI

struct PrivacyStatement: View
{
    @Binding var showSelf:Bool
    var body: some View
    {
        VStack
        {
            
            Spacer()
            Image(systemName: "checkmark.shield")
                .font(.system(size: 50))
                .frame(width: 110, height: 110)
                .foregroundStyle(.brandPrimary)
                .background
                {
                    Circle()
                        .fill(.brandPrimaryLight)
                }
                .padding(.bottom, 18)
            Text("Privacy Statement")
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 12)
                .foregroundStyle(.textPrimary)
            Text("InBloom only collects your name and email, that’s it. We use this info to\ncreate your account and keep your garden growing. We never sell, rent, or share your data with third parties.")
                .font(.system(size: 20))
                .foregroundStyle(.textSecondary)
                .multilineTextAlignment(.center)
                .frame(width: 350)
            Spacer()
            Spacer()
            Spacer()
            Button(action: continuePressed)
            {
                Text("Continue")
                    .font(.system(size: 20, weight: .semibold))
            }
            .frame(width: 380, height: 60)
            .foregroundStyle(.textOnPrimary)
            .background
            {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .foregroundStyle(.brandPrimary)
            }
        }
    }
    
    func continuePressed()
    {
        withAnimation
        {
            showSelf = false
        }
    }
}


#Preview
{
    @Previewable @State var test:Bool = true
    PrivacyStatement(showSelf: $test)
}
