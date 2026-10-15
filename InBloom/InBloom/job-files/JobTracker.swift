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
    @State private var showAddSheet:Bool = true // should be false when not testing
    @State private var jobs:[Job] = []
    @State private var jobPasteField:String = ""
//    let exampleJobs:[Job] = [Job(title: "Job Title 1", items: ["first task", "second task"], itemCompletion: [true, false], isSaved: false, deadline: Date(timeIntervalSince1970: 1795000000), link: ""), Job(title: "Job Title 2", items: ["wake up", "grab a brush"], itemCompletion: [false, false], isSaved: true, deadline: Date(timeIntervalSince1970: 1795000000), link: "")]
    
    var body: some View
    {
        ZStack
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack
            {
                VStack(alignment: .leading, spacing: 10)
                {
                    Text("Job tracker")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.textPrimary)
                    Text("0 jobs tracked")
                        .foregroundStyle(.textSecondary)
                }
                .padding(.leading, 20)
                .padding(.top, 20)
                .padding(.bottom, 80)
                .frame(maxWidth: .infinity, alignment: .leading)
                if(jobs.isEmpty)
                {
                    VStack(spacing: 10)
                    {
                        Text("No jobs yet")
                            .foregroundStyle(.textPrimary)
                            .font(.system(size: 20, weight: .semibold))
                        Text("Tap \"+ Add a job\" to start tracking an application.")
                            .foregroundStyle(.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: 300)
                    Spacer()
                }
                Button
                {
                    showAddSheet = true
                } label:
                {
                    Text("+ Add a job")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.textOnPrimary)
                        .frame(width: 356, height: 46)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 18))
                .tint(.brandPrimary)
                .padding(.bottom, 40)
            }
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
                    .foregroundStyle(.brandPrimary)
                    .font(.system(size: 20, weight: .semibold))
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
                    showAddSheet = true
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
    
    func temp()
    {
        
    }
}

#Preview
{
    JobTracker(navVM: NavigationViewModel())
}
