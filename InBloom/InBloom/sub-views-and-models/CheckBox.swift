//
//  CheckBox.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct CheckBox: View
{
    let cornerRadius:CGFloat = 8
    let borderWidth:CGFloat = 2
    
    var checked:Bool
    
    var body: some View
    {
        ZStack
        {
            RoundedRectBackground(color: checked ? .brandPrimary : .clear, cornerRadius: cornerRadius, borderColor: checked ? .brandPrimary : .textSecondary, borderWidth: borderWidth)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 28)
            Image(systemName: "checkmark")
                .symbolEffect(.drawOn, isActive: !checked)
                .font(.section)
                .foregroundStyle(.textOnPrimary)
        }
    }
}

#Preview
{
    CheckBox(checked: false)
}
