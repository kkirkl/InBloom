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
                .font(.system(size: 44))
                .frame(width: 96, height: 96)
                .foregroundStyle(.brandPrimary)
                .background
                {
                    Circle()
                        .fill(.brandPrimaryLight)
                }
                .padding(.bottom, 18)
            Text("Privacy Statement")
                .font(.system(size: 28, weight: .bold))
                .padding(.bottom, 12)
                .foregroundStyle(.textPrimary)
            Text("InBloom only collects your name and email, that’s it. We use this info to\ncreate your account and keep your garden growing. We never sell, rent, or share your data with third parties.")
                .font(.system(size: 16))
                .foregroundStyle(.textSecondary)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
            Button(action: continuePressed)
            {
                Text("Continue")
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(width: 354, height: 56)
            .foregroundStyle(.textOnPrimary)
            .background
            {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundStyle(.brandPrimary)
            }
        }
        .frame(width: 306)
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
