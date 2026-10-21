//
//  JobDetailScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct JobDetailScreen: View
{
    @ObservedObject private var navVM:NavigationViewModel
    @Binding private var jobs:[Job]
    @Binding private var job:Job
    
    init(_ navVM:NavigationViewModel, jobs:Binding<[Job]>, jobIndex:Int)
    {
        self.navVM = navVM
        self._jobs = jobs
        self._job = jobs[jobIndex]
    }
    
    var body: some View
    {
        DefaultVStack
        {
            HStack
            {
                Text("Job Details")
                    .screenTitle()
                Spacer()
            }
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
                VStack(alignment: .leading)
                {
                    Text(job.title)
                        .section()
                    Text(job.company)
                        .caption()
                }
                Spacer()
                VStack(alignment: .trailing)
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
                    Button("Edit details")
                    {
                        // TODO
                    }
                    .font(.body)
                    .foregroundStyle(.brandPrimary)
                    .fontWeight(.semibold)
                }
            }
            ScrollView
            {
                HStack
                {
                    Text("plant art here :)")
                        .section()
                        .padding(.vertical, 40)
                        .frame(maxWidth: .infinity)
                        .background
                    {
                        RoundedRectBackground(color: .backgroundSurface, cornerRadius: 16,
                                              borderColor: .borderDefault,
                                              borderWidth: 1)
                    }
                    
                }
                VStack(alignment: .leading)
                {
                    Text("NEXT STEP")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.brandPrimary)
                    Text(job.nextItem ?? "")
                        .font(.body)
                        .fontWeight(.semibold)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background
                {
                    RoundedRectBackground(color: .brandPrimaryLight, cornerRadius: 16)
                }
                .padding(.bottom, 32)
                VStack
                {
                    HStack
                    {
                        Text("Application steps")
                            .section()
                        Spacer()
                        Button("Edit steps")
                        {
                            // TODO
                        }
                        .font(.body)
                        .foregroundStyle(.brandPrimary)
                        .fontWeight(.semibold)
                    }
                    LazyVStack(alignment: .leading)
                    {
                        ForEach(job.items, id: \.self)
                        {(item) in
                            Button
                            {
                                
                            } label:
                            {
                                HStack
                                {
                                    RoundedRectBackground(color: .clear, cornerRadius: 8,
                                                          borderColor: .textSecondary,
                                                          borderWidth: 2)
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 28)
                                    Text(item)
                                        .font(.body)
                                        .foregroundStyle(.textPrimary)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity)
                                .background
                                {
                                    RoundedRectBackground(color: .backgroundSurface,
                                                          cornerRadius: 12,
                                                          borderColor: .borderDefault,
                                                          borderWidth: 1)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview
{
    @Previewable @State var test:[Job] = [Job(company: "Roblox", title: "Product Designer")]
    JobDetailScreen(NavigationViewModel(), jobs: $test, jobIndex: 0)
}
