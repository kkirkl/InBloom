//
//  JobListItem.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct JobListItem: View
{
    @ObservedObject var navVM:NavigationViewModel
    @State var job:Job
    
    var body: some View
    {
        HStack
        {
            Text("[plant here]")
                .padding()
            VStack(alignment: .leading)
            {
                Text(job.title)
                    .font(.title)
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
                        .foregroundStyle(Color(white: 0.5))
                        .tint(.none)
                    }
                    Spacer()
                    Text("step \(job.completedItems()) of \(job.items.count)")
                }
            }
            .padding(.vertical, 8)
            Image(systemName: "chevron.right")
                .font(.system(size: 20))
                .foregroundStyle(.gray)
                .padding(.trailing, 15)
                .padding(.leading, 50)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .border(.gray, width: 2.5)
        .onTapGesture
        {
            navVM.pushJobDetail(job: job)
        }
    }
}

#Preview
{
    JobListItem(navVM: NavigationViewModel(), job: Job(title: "Job Title", items: [], itemCompletion: [], isSaved: false, deadline: Date(timeIntervalSince1970: 10000000), link: "http://idklol.com"))
}
