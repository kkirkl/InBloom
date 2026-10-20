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
    let buttonInternalPadding:CGFloat = 18
    let buttonCornerRadius:CGFloat = 16
    let filterHorizontalInternalPadding:CGFloat = 14
    let filterVerticalInternalPadding:CGFloat = 8
    let filterCornerRadius:CGFloat = 100
    let filterBorderWidth:CGFloat = 1
    
    @ObservedObject var navVM:NavigationViewModel
    @State private var showAddSheet:Bool = false // should be false when not testing
    @Binding private var jobs:[Job]
    @State private var jobPasteField:String = ""
    @State private var currentFilter:JobFilter?
    
    init(_ navVM:NavigationViewModel, jobs:Binding<[Job]>)
    {
        self.navVM = navVM
        self._jobs = jobs
    }
    
    var body: some View
    {
        DefaultVStack
        {
            VStack(alignment: .leading, spacing: 10)
            {
                Text("Job tracker")
                    .screenTitle()
                Text("\(jobs.count) jobs tracked")
                    .caption()
                HStack(spacing: 4)
                {
                    Button
                    {
                        currentFilter = nil
                    } label:
                    {
                        Text("All \(jobs.count)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(currentFilter == nil ? .textOnPrimary : .textPrimary)
                            .padding(.vertical, filterVerticalInternalPadding)
                            .padding(.horizontal, filterHorizontalInternalPadding)
                            .background
                            {
                                RoundedRectBackground(
                                    color: currentFilter == nil ?
                                           .brandPrimary : .backgroundSurface,
                                    cornerRadius: filterCornerRadius,
                                    borderColor: currentFilter == nil ?
                                                 .brandPrimary : .borderDefault,
                                    borderWidth: filterBorderWidth)
                            }
                    }
                    ForEach(JobFilter.allCases, id: \.self)
                    {(filter) in
                        Button
                        {
                            currentFilter = filter
                        } label:
                        {
                            Text("\(filter.description) \(filteredJobs(jobs, filter:filter).count)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(currentFilter == filter ?
                                                 .textOnPrimary : .textPrimary)
                                .padding(.vertical, filterVerticalInternalPadding)
                                .padding(.horizontal, filterHorizontalInternalPadding)
                                .background
                                {
                                    RoundedRectBackground(
                                        color: currentFilter == filter ?
                                               .brandPrimary : .backgroundSurface,
                                        cornerRadius: filterCornerRadius,
                                        borderColor: currentFilter == filter ?
                                                     .brandPrimary : .borderDefault,
                                        borderWidth: filterBorderWidth)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            JobList(jobs: $jobs, filter: currentFilter)
            Button
            {
                showAddSheet = true
            } label:
            {
                Text("+ Add a job")
                    .font(.button)
                    .foregroundStyle(.brandPrimary)
                    .padding(.vertical, buttonInternalPadding)
                    .frame(maxWidth: .infinity)
                    .background
                    {
                        RoundedRectBackground(color: .clear,
                                              cornerRadius: buttonCornerRadius,
                                              borderColor: .brandPrimary,
                                              borderWidth: 2,
                                              dash: [6, 4])
                    }
            }
            .padding(.bottom, 40)
        }
        .sheet(isPresented: $showAddSheet)
        {
            VStack(alignment: .leading, spacing: 10)
            {
                HStack
                {
                    Text("Add a job")
                        .font(.system(size: 22, weight: .semibold))
                    Spacer()
                }
                .padding(.bottom, 15)
                HStack
                {
                    VStack(alignment: .leading, spacing: 4)
                    {
                        Text("Job URL")
                            .font(.system(size: 16))
                            .foregroundStyle(.textSecondary)
                        TextField("job paste textfield", text: $jobPasteField,
                                  prompt: Text("Paste link here"))
                        .font(.system(size: 20))
                    }
                    Button("Paste")
                    {
                        // TODO
                    }
                    .foregroundStyle(jobPasteField.isEmpty ? .textDisabled : .brandPrimary)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 20, weight: .semibold))
                    .disabled(jobPasteField.isEmpty)
                }
                .padding(20)
                .overlay
                {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(lineWidth: 1.25)
                        .foregroundStyle(.borderDefault)
                }
                Text("We'll try to fill in the details for you.")
                    .foregroundStyle(.textSecondary)
                Spacer()
                Text("or")
                    .foregroundStyle(.textSecondary)
                    .frame(maxWidth: .infinity)
                Spacer()
                Button
                {
                    showAddSheet = false
                    navVM.pushScreen(screen: .addJob)
                } label:
                {
                    Text("+ Add manually")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.brandPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                }
                .buttonBorderShape(.roundedRectangle(radius: 18))
                .tint(.brandPrimary)
                .overlay
                {
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(lineWidth: 1.5)
                        .foregroundStyle(.brandPrimary)
                }
            }
            .padding(.top, 28)
            .padding(20)
            .frame(maxWidth: .infinity)
            .presentationSizing(.automatic)
            .presentationDetents([.fraction(2 / 5)])
            .presentationDragIndicator(.visible)
            .presentationBackground
            {
                Color(.backgroundDefault)
            }
        }
    }
}

#Preview
{
    @Previewable @State var jobs:[Job] =
    [Job(company: "Roblox", title: "Product Designer"),
    Job(company: "wawawa", title: "oooooo")]
    JobTracker(NavigationViewModel(), jobs: $jobs)
}
