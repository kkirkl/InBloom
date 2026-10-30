//
//  PlantView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/13/26.
//

import SwiftUI

struct PlantView: View
{
    var image:ImageResource?
    
    init(steps:Int, completed:Int)
    {
        let stepSize:Double = Double(1) / Double(Stage.allCases.count - 1)
        var percentage:Double = Double(completed) / Double(steps)
        var stage:Stage = completed == steps ? .bloomed : .planted
        for i in 0 ..< Stage.allCases.count - 1
        {
            if (stepSize * Double(i)) <= percentage
                && percentage < (stepSize * Double(i + 1))
            {
                stage = Stage.allCases[i]
            }
        }
        switch stage
        {
            case .planted:
                image = .plantStage1
            case .sprouting:
                image = .plantStage2
            case .growing:
                image = .plantStage3
            case .budding:
                image = .plantStage4
            case .bloomed:
                image = .plantStage5
        }
    }
    
    var body: some View
    {
        Image(image!)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            
    }
}

#Preview
{
    PlantView(steps: 10, completed: 10)
}
