//
//  EditStepsScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct EditStepsScreen: View
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
            List
            {
                ForEach(job.items.indices, id: \.self)
                {(index) in
                    HStack
                    {
                        Button
                        {
                            withAnimation(.interactiveSpring)
                            {
                                job.items.remove(at: index)
                                job.itemCompletion.remove(at: index)
                            }
                        } label:
                        {
                            Image(systemName: "minus.circle.fill")
                                .font(.section)
                                .foregroundStyle(.stateError)
                        }
                        Text(job.items[index])
                            .font(.body)
                            .foregroundStyle(.textPrimary)
                        Spacer()
                        Image(systemName: "circle.grid.3x3.fill")
                            .foregroundStyle(.textSecondary)
                        
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
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .scrollContentBackground(.hidden)
                }
                .onDelete
                {(indexSet) in
                    job.items.remove(atOffsets: indexSet)
                    job.itemCompletion.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .listRowSpacing(-22)
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
    EditStepsScreen(NavigationViewModel(), jobs: $test, jobIndex: 0)
}
