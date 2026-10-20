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
    var cornerRadius:CGFloat
    var borderColor:Color = .clear
    var borderWidth:CGFloat = 0
    var dash:[CGFloat] = []
    
    
    var body: some View
    {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundStyle(color)
            .overlay
            {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(style: StrokeStyle(lineWidth: borderWidth, dash: dash))
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
                                  cornerRadius: 12,
                                  borderColor: .borderDefault,
                                  borderWidth: 2,
                                  dash: [5])
        }
}
