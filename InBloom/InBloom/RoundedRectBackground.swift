//
//  RoundedRectBackground.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/15/26.
//

import SwiftUI

struct RoundedRectBackground: View
{
    var color:Color
    var borderColor:Color
    var cornerRadius:CGFloat
    var borderWidth:CGFloat
    
    
    var body: some View
    {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundStyle(color)
            .overlay
            {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(lineWidth: borderWidth)
                    .foregroundStyle(borderColor)
            }
    }
}

#Preview
{
    Text("wowie")
        .padding(5)
        .background
        {
            RoundedRectBackground(color: .backgroundSurface,
                                  borderColor: .borderDefault,
                                  cornerRadius: 12,
                                  borderWidth: 2)
        }
}
