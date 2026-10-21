//
//  DefaultContainer.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

struct DefaultVStack<Content:View>: View
{
    var alignment:HorizontalAlignment
    var spacing:CGFloat?
    var padding:CGFloat
    var content: () -> Content
    
    init(alignment:HorizontalAlignment = .center, spacing:CGFloat? = nil, padding:CGFloat = 20,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.alignment = alignment
        self.spacing = spacing
        self.padding = padding
        self.content = content
    }
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack(alignment: alignment, spacing: spacing, content: content)
                .padding(padding)
        }
    }
}

#Preview
{
    DefaultVStack
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
