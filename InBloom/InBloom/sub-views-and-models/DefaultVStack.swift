//
//  DefaultContainer.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

struct DefaultContainer<Content:View>: View
{
    var alignment:HorizontalAlignment
    var spacing:CGFloat?
    var content: () -> Content
    
    init(alignment:HorizontalAlignment = .center, spacing:CGFloat? = nil, @ViewBuilder content: @escaping () -> Content)
    {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack(alignment: alignment, spacing: spacing, content: content)
                .padding(20)
        }
    }
}

#Preview
{
    DefaultContainer
    {
        Text("wowie?")
        Text("zowie?")
        HStack
        {
            Text("1")
            Text("2")
        }
    }
}
