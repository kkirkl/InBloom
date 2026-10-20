//
//  JobList.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct JobList: View
{
    @Binding private var jobs:[Job]
    
    init(jobs:Binding<[Job]>)
    {
        self._jobs = jobs
    }
    
    var body: some View
    {
        if jobs.isEmpty
        {
            VStack(spacing: 10)
            {
                Spacer()
                Text("No jobs yet")
                    .section()
                Text("Tap \"+ Add a job\" to start tracking an application.")
                    .body()
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .frame(width: 300)
            Spacer()
        } else
        {
            ScrollView
            {
                ForEach($jobs, id: \.self)
                {(job) in
                    JobListItem(job: job)
                }
            }
        }
    }
}

#Preview
{
    @Previewable @State var jobs:[Job] =
        [Job(company: "Roblox", title: "Product Designer"),
        Job(company: "Roblox again", title: "idk")]
    DefaultVStack
    {
        JobList(jobs: $jobs)
    }
}
