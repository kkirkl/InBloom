//
//  ConfirmEmail.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/15/26.
//

import SwiftUI

let verificationCodeLength:Int = 6

struct ConfirmEmail: View
{
    @State private var nums:[String] = Array(repeating: "", count: verificationCodeLength)
    @FocusState private var focusedDigit:Int?
    
    let digits:Regex = /[0-9]/
    let screenTitleFont:Font = .system(size: 28, weight: .bold)
    let subtitleFont:Font = .system(size: 16)
    let rectCornerRadius:CGFloat = 12
    let email:String
    
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 60)
            {
                VStack(alignment: .leading, spacing: 12)
                {
                    Text("Confirm your email")
                        .font(screenTitleFont)
                        .foregroundStyle(.textPrimary)
                    Text("We've sent a code to \(email)")
                        .font(subtitleFont)
                        .foregroundStyle(.textSecondary)
                }
                VStack
                {
                    Text("\(verificationCodeLength)-DIGIT CODE")
                        .font(subtitleFont)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textSecondary)
                    HStack
                    {
                        ForEach(nums.indices, id: \.self)
                        {(index) in
                            TextField("code field \(index)", text: $nums[index], prompt: Text("•"))
                                .textContentType(.oneTimeCode)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(screenTitleFont)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(0.8, contentMode: .fit)
                                .background
                                {
                                    RoundedRectBackground(color: .backgroundSurface, cornerRadius: rectCornerRadius, borderColor: .borderDefault, borderWidth: 1)
                                }
//                                .onReceive(nums[index])
//                                {(newValue) in
//                                    
//                                }
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
        }
    }
}

#Preview
{
    ConfirmEmail(email: "example@test.temp")
}
