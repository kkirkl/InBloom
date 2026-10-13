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
//    let exampleJobs:[Job] = [Job(title: "Job Title 1", items: ["first task", "second task"], itemCompletion: [true, false], isSaved: false, deadline: Date(timeIntervalSince1970: 1795000000), link: ""), Job(title: "Job Title 2", items: ["wake up", "grab a brush"], itemCompletion: [false, false], isSaved: true, deadline: Date(timeIntervalSince1970: 1795000000), link: "")]
    @State private var jobs:[Job] = []
    var body: some View
    {
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
            Button("+ Add a job")
            {
            }
            .font(.system(size: 20, weight: .semibold))
            .frame(width: 380, height: 60)
            .foregroundStyle(.textOnPrimary)
            .background
            {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .foregroundStyle(.brandPrimary)
            }
            .padding(.bottom, 20)
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
