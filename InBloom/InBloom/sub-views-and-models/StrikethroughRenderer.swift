//
//  StrikethroughRenderer.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 11/15/26.
//
//  based on: https://lickability.com/blog/animating-strikethroughs-in-swiftui/

import SwiftUI

struct StrikethroughRenderer: TextRenderer
{
    var animatableData:CGFloat
    {
        get {_progress}
        set {_progress = newValue}
    }

    var color:Color
    var lineWidth:CGFloat
    var _progress:CGFloat
    
    init(enabled:Bool, color:Color, lineWidth:CGFloat, _progress:CGFloat = 0)
    {
        self.color = color
        self.lineWidth = lineWidth
        self._progress = enabled ? 1 : 0
    }
    
    func draw(layout:Text.Layout, in ctx: inout GraphicsContext)
    {
        let totalLength = layout.reduce(0) {$0 + $1.typographicBounds.width}
        var accumulated:CGFloat = 0

        for line in layout
        {
            let bounds = line.typographicBounds
            let strikeWidth = min(max(totalLength * _progress - accumulated, 0), bounds.width)
             
            ctx.draw(line)

            if strikeWidth > 0
            {
                let midY = bounds.rect.midY
                let startX = bounds.rect.minX
                ctx.stroke(
                    Path
                    {(path) in
                        path.move(to: CGPoint(x: startX, y: midY))
                        path.addLine(to: CGPoint(x: startX + strikeWidth, y: midY))
                    },
                    with: .color(color),
                    lineWidth: lineWidth)
            }
            accumulated += bounds.width
        }
    }
}
