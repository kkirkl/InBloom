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
    @Binding private var jobs:[Job]
    
    init(navVM: NavigationViewModel, jobs:Binding<[Job]>)
    {
        self.navVM = navVM
        self._jobs = jobs
    }
    
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
                        .screenTitle()
                    Text("0 plants")
                        .caption()
                }
                .padding(.bottom, 80)
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack
                {
                    VStack(spacing: 10)
                    {
                        Text("Your garden is empty")
                            .section()
                        Text("Add a job in Job Tracker to plant your first seed.")
                            .body()
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 300)
                    Spacer()
                    HStack
                    {
                        ForEach(jobs, id: \.id)
                        {(job) in
                            PlantView(job: job)
                        }
                    }
                    Spacer()
                }
            }
            .padding(20)
        }
    }
}

#Preview
{
    @Previewable @State var jobs:[Job] =
        [Job(company: "Roblox", title: "Product Designer"),
        Job(company: "Roblox again", title: "idk")]
    GardenScreen(navVM: NavigationViewModel(), jobs: $jobs)
}
