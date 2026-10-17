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
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack
            {
                Spacer()
                Image(.gardenBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .ignoresSafeArea()
            VStack
            {
                VStack(alignment: .leading, spacing: 10)
                {
                    Text("Your garden")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.textPrimary)
                    Text("0 plants")
                        .foregroundStyle(.textSecondary)
                }
                .padding(.leading, 20)
                .padding(.top, 20)
                .padding(.bottom, 80)
                .frame(maxWidth: .infinity, alignment: .leading)
                PlantView()
            }
        }
//        .ignoresSafeArea()
    }
}

#Preview
{
    GardenScreen(navVM: NavigationViewModel())
}
