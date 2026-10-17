//
//  JobDetailScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct JobDetailScreen: View
{
    @State var job:Job
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text("[plant here]")
                    .padding()
                VStack(alignment: .leading)
                {
                    HStack
                    {
                        Text(job.title)
                            .font(.title)
                        Spacer()
                        Image(systemName: "arrow.up.forward.square")
                            .font(.system(size: 22))
                            .foregroundStyle(.blue)
                    }
                    HStack
                    {
                        if job.isSaved
                        {
                            Button("\(Image(systemName: "bookmark.fill"))")
                            {
                                job = job.toggledSaved()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.green)
                        } else
                        {
                            Button("\(Image(systemName: "bookmark"))")
                            {
                                job = job.toggledSaved()
                            }
                            .buttonStyle(.bordered)
                            .tint(.none)
                            .foregroundStyle(Color(white: 0.5))
                        }
                        Spacer()
                        Text("Deadline: \(Job.getJobDeadlineString(date: job.deadline))")
                    }
                }
                .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            Rectangle()
                .fill(.gray)
                .frame(height: 2)
                .padding(.horizontal, 15)
            VStack(alignment: .leading)
            {
                ForEach(job.items, id: \.self)
                {(item) in
                    HStack
                    {
                        Image(systemName: "square")
                        Text(item)
                    }
                    .font(.system(size: 22))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            .padding(.top, 15)
            Spacer()
        }
    }
}

#Preview
{
//    JobDetailScreen(job: Job(title: "Job Title", items: ["example", "example 2"], itemCompletion: [], isSaved: false, deadline: Date(timeIntervalSince1970: 1795000000), link: "http://idklol.com"))
}
