//
//  GardenScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct GardenScreen: View
{
    @ObservedObject var navVM:NavigationViewModel
    var body: some View
    {
        VStack
        {
            Spacer()
            Image(.emptyGardenPlaceholder)
        }
    }
}

#Preview
{
    GardenScreen(navVM: NavigationViewModel())
}
