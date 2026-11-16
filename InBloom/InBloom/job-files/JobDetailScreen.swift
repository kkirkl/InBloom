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
    @Binding private var currentTab:TabScreen
    @Binding private var jobs:[Job]
    @Binding private var job:Job
    var jobIndex:Int
    
    var nextStepMessage:String
    {
        let nextStep:String? = job.nextItem()
        if nextStep != nil
        {
            return nextStep!
        } else if job.itemCount() == 0
        {
            return "No steps yet!"
        }
        
        return ""
    }
    
    var nextStep: some View
    {
        VStack(alignment: .leading)
        {
            Text("NEXT STEP")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.brandPrimary)
            Text(nextStepMessage)
                .font(.body)
                .fontWeight(.semibold)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 56)
        .background
        {
            RoundedRectBackground(color: .brandPrimaryLight, cornerRadius: 16)
        }
        .transaction
        {(transaction) in
            transaction.animation = nil
        }
    }
    
    var viewPlant: some View
    {
        Button
        {
            currentTab = .garden
        } label:
        {
            Text("View Plant")
                .font(.button)
                .foregroundStyle(.textOnPrimary)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background
                {
                    RoundedRectBackground(color: .brandPrimary, cornerRadius: 16)
                }
        }
    }
    
    init(_ navVM:NavigationViewModel, _ currentTab:Binding<TabScreen>, jobs:Binding<[Job]>, jobIndex:Int)
    {
        self.navVM = navVM
        self._currentTab = currentTab
        self._jobs = jobs
        self._job = jobs[jobIndex]
        self.jobIndex = jobIndex
    }
    
    var body: some View
    {
        DefaultVStack
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
                VStack(alignment: .leading)
                {
                    Text(job.getTitle())
                        .section()
                    Text(job.getCompany())
                        .caption()
                }
                Spacer()
                VStack(alignment: .trailing)
                {
                    Button
                    {
                        job = job.savedToggled()
                    } label:
                    {
                        Text("Saved")
                            .font(.caption)
                            .foregroundStyle(job.isSaved() ? .textOnPrimary : .textSecondary)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                    }
                    .background
                    {
                        RoundedRectBackground(color: job.isSaved() ?
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
                    ZStack
                    {
                        Group
                        {
                            Image(.emptyPot)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            PlantView(job: job)
                                .transaction
                                {(transaction) in
                                    transaction.animation = .linear
                                }
                        }
                        .frame(width: 80, height: 101)
                    }
                    VStack(alignment: .leading, spacing: 8)
                    {
                        Text("YOUR PLANT")
                            .caption()
                            .fontWeight(.semibold)
                        Text(job.plantStage().description)
                            .section()
                            .padding(.top, -3)
                            .transaction
                            {(transaction) in
                                transaction.animation = nil
                            }
                        ProgressView(value: job.completionPercentage())
                            .background(.backgroundDefault)
                            .clipShape(.capsule)
                            .tint(.brandPrimary)
                            .scaleEffect(x: 1, y: 2)
                            .transaction
                            {(transaction) in
                                transaction.animation = .easeInOut
                            }
                        Text("\(job.completedCount()) of \(job.itemCount()) "
                             + "· next stage in \(job.itemsTillNextStage()) "
                             + "step\(job.itemsTillNextStage() == 1 ? "" : "s" )")
                            .caption()
                    }
                    .padding(.leading, 16)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .background
                {
                    RoundedRectBackground(color: .backgroundSurface, cornerRadius: 16,
                                          borderColor: .borderDefault,
                                          borderWidth: 1)
                }
                if !job.isCompleted()
                {
                    nextStep
                        .padding(.bottom, 32)
                } else
                {
                    viewPlant
                        .padding(.bottom, 32)
                }
                
                VStack
                {
                    HStack
                    {
                        Text("Application steps")
                            .section()
                        Spacer()
                        Button("Edit steps")
                        {
                            navVM.pushEditSteps(index: jobIndex)
                        }
                        .font(.body)
                        .foregroundStyle(.brandPrimary)
                        .fontWeight(.semibold)
                    }
                    LazyVStack(alignment: .leading, spacing: 6)
                    {
                        ForEach(0 ..< job.itemCount(), id: \.self)
                        {(index) in
                            Button
                            {
                                job = job.itemToggled(at: index) ?? job
                                
                            } label:
                            {
                                HStack
                                {
                                    CheckBox(checked: job.isItemComplete(itemIndex: index)!)
                                    Text(job.getItem(at: index)!)
                                        .font(.body)
                                        .textRenderer(StrikethroughRenderer(
                                            enabled: job.isItemComplete(itemIndex: index)!,
                                            color: .textSecondary, lineWidth: 1))
                                        .foregroundStyle(job.isItemComplete(itemIndex: index)! ?
                                            .textSecondary : .textPrimary)
                                        .transaction
                                        {(transaction) in
                                            transaction.animation = .linear
                                        }
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            ToolbarItem(placement: .principal)
            {
                Text("Job Details")
                    .screenTitle()
            }
            Group
            {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Text("")
                }
                ToolbarItem(placement: .topBarTrailing)
                {
                    Text("")
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}

#Preview
{
    @Previewable @State var test:[Job] = [Job(company: "Roblox", title: "Product Designer")]
    @Previewable @State var currentTab:TabScreen = .jobs
    JobDetailScreen(NavigationViewModel(), $currentTab, jobs: $test, jobIndex: 0)
}
