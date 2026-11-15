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
    
    init(job:Job)
    {
        let stage:PlantStage = job.plantStage()
        switch stage
        {
            case .planted:
            image = .plantStage1Blue
            case .sprouting:
                image = .plantStage2Blue
            case .growing:
                image = .plantStage3Blue
            case .budding:
                image = .plantStage4Blue
            case .bloomed:
                image = .plantStage5Blue
        }
    }
    
    var body: some View
    {
        Image(image!)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview
{
    let job:Job = Job(company: "test", title: "testststs",
                      items: ["", "", "", ""],
                      itemCompletion: [false, false, false, false])
    PlantView(job: job)
}
