//
//  JobListItem.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct JobListItem: View
{
    @ObservedObject private var navVM:NavigationViewModel
    @Binding private var job:Job
    var jobIndex:Int
    
    init(_ navVM:NavigationViewModel, job:Binding<Job>, jobIndex:Int)
    {
        self.navVM = navVM
        self._job = job
        self.jobIndex = jobIndex
    }
    
    var body: some View
    {
        Button
        {
            navVM.pushJobDetail(index: jobIndex)
        } label:
        {
            HStack
            {
                Image(systemName: "suitcase")
                    .font(.section)
                    .foregroundStyle(.textSecondary)
                    .padding(8)
                    .background
                    {
                        RoundedRectBackground(color: .backgroundMuted, cornerRadius: 12)
                    }
                VStack(alignment: .leading, spacing: 4)
                {
                    Text(job.title)
                        .font(.body)
                        .foregroundStyle(.textPrimary)
                        .fontWeight(.semibold)
                    Text(job.company)
                        .caption()
                        .padding(.bottom, 1)
                    HStack
                    {
                        Button
                        {
                            job.isSaved.toggle()
                        } label:
                        {
                            Text("Saved")
                                .font(.caption)
                                .foregroundStyle(job.isSaved ? .textOnPrimary : .textSecondary)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                        }
                        .background
                        {
                            RoundedRectBackground(color: job.isSaved ?
                                                  .brandPrimary : .backgroundMuted,
                                                  cornerRadius: 100)
                        }
                        Text("\(job.completedCount) of \(job.items.count) steps")
                            .caption()
                    }
                    
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.textSecondary)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background
            {
                RoundedRectBackground(color: .backgroundSurface, cornerRadius: 16, borderColor: .borderDefault, borderWidth: 1)
            }
        }
    }
}

#Preview
{
    @Previewable @State var example:Job = Job(company: "Roblox", title: "Product Designer")
    DefaultVStack
    {
        JobListItem(NavigationViewModel(), job: $example, jobIndex: 0)
    }
}
