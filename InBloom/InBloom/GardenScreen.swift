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
                VStack
                {
                    VStack(spacing: 10)
                    {
                        Text("Your garden is empty")
                            .foregroundStyle(.textPrimary)
                            .font(.system(size: 20, weight: .semibold))
                        Text("Add a job in Job Tracker to plant your first seed.")
                            .foregroundStyle(.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 300)
                    Spacer()
                }
            }
        }
//        .ignoresSafeArea()
    }
}

#Preview
{
    GardenScreen(navVM: NavigationViewModel())
}
