//
//  PlantStage.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/30/26.
//

enum PlantStage: CaseIterable
{
    case planted
    case sprouting
    case growing
    case budding
    case bloomed
    
    var description:String
    {
        switch self
        {
        case .planted:
            "Seed Planted"
        case .sprouting:
            "Sprouting"
        case .growing:
            "Growing"
        case .budding:
            "Almost Bloomed"
        case .bloomed:
            "Bloomed!"
        }
    }
}
