//
//  PlantView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/13/26.
//

import SwiftUI

struct PlantView: View
{
    enum Stage: CaseIterable
    {
        case planted
        case sprouting
        case growing
        case budding
        case bloomed
    }
    
    var image:ImageResource?
    
    init(steps:Int, completed:Int)
    {
        let stepSize:Double = Double(1) / Double(Stage.allCases.count)
        var percentage:Double = Double(steps) / Double(completed)
        var stage:Stage = .planted
        for i in Stage.allCases.indices
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
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview
{
    PlantView(steps: 5, completed: 4)
}
