//
//  JobList.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct JobList: View
{
    @ObservedObject private var navVM:NavigationViewModel
    @Binding private var jobs:[Job]
    var filter:JobFilter?
    
    init(_ navVM:NavigationViewModel, jobs:Binding<[Job]>, filter:JobFilter?)
    {
        self.navVM = navVM
        self._jobs = jobs
        self.filter = filter
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
                ForEach(jobs.indices, id: \.self)
                {(index) in
                    if filter == nil || filter!.filterFunction(jobs[index])
                    {
                        JobListItem(navVM, job: $jobs[index], jobIndex: index)
                    }
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
        JobList(NavigationViewModel(), jobs: $jobs, filter: nil)
    }
}
