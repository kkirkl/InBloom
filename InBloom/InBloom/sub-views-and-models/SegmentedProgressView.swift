//
//  SegmentedProgressView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 11/13/26.
//

import SwiftUI

struct SegmentedProgressView: View
{
    let value:Int
    let total:Int
    let height:CGFloat
    let completeColor:Color
    let incompleteColor:Color
    
    init(value:Int, total:Int, height:CGFloat = 4, completeColor:Color = .brandPrimary,
         incompleteColor:Color = .backgroundMuted)
    {
        self.value = value
        self.total = total
        self.completeColor = completeColor
        self.incompleteColor = incompleteColor
        self.height = height
    }
    
    var body: some View
    {
        if total <= 6
        {
            HStack
            {
                ForEach(0 ..< total, id: \.self)
                {(index) in
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundStyle(index < value ? completeColor : incompleteColor)
                }
            }
            .frame(height: height)
        } else
        {
            ProgressView(value: Double(value), total: Double(total))
                .background(incompleteColor)
                .clipShape(.capsule)
                .tint(completeColor)
                .scaleEffect(x: 1, y: (height / 4))
                
            
        }
    }
}

#Preview
{
    SegmentedProgressView(value: 2, total: 6, height: 8)
}
