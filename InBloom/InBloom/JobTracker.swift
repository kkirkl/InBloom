//
//  JobTracker.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

let tagFont:Font = .system(size: 24)
let tagNumFont:Font = .system(size: 24 * 0.6)

struct JobTracker: View
{
    @ObservedObject var navVM:NavigationViewModel
    let exampleJobs:[Job] = [Job(title: "Job Title 1", items: ["first task", "second task"], itemCompletion: [true, false], isSaved: false, deadline: Date(timeIntervalSince1970: 1795000000), link: ""), Job(title: "Job Title 2", items: ["wake up", "grab a brush"], itemCompletion: [false, false], isSaved: true, deadline: Date(timeIntervalSince1970: 1795000000), link: "")]
    var body: some View
    {
        VStack
        {
            VStack(alignment: .leading)
            {
                Text("Job Tracker")
                    .font(.system(size: 40))
                Text("Jobs tracked: 0")
                HStack
                {
                    VStack
                    {
                        Text("All")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                            .aspectRatio(1, contentMode: .fill)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                    VStack
                    {
                        Text("Saved")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                    }
                    Spacer()
                    VStack
                    {
                        Text("In Progress")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                    }
                    Spacer()
                    VStack
                    {
                        Text("Done")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                    }
                }
            }
            Spacer()
            VStack
            {
                ForEach(exampleJobs, id: \.self)
                {(job) in
                    JobListItem(navVM: navVM, job: job)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

#Preview
{
    JobTracker(navVM: NavigationViewModel())
}
