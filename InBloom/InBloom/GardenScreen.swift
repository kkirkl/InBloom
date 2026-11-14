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
                    Text("\(jobs.count) plant\(jobs.count == 1 ? "" : "s")")
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
                        Spacer()
                        ForEach(jobs, id: \.id)
                        {(job) in
                            VStack
                            {
                                PlantView(job: job)
                                    .frame(width: 120)
                                Text("\(job.title) · \(job.company)")
                                    .font(.body)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
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
