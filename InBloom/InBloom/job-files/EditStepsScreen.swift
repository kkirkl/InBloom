//
//  EditStepsScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct EditStepsScreen: View
{
    enum Field: Hashable
    {
        case newStep
        case editStep
    }
    
    let buttonInternalPadding:CGFloat = 18
    let buttonCornerRadius:CGFloat = 16
    
    @ObservedObject private var navVM:NavigationViewModel
    @FocusState private var focusedField:Field?
    @Binding private var jobs:[Job]
    @Binding private var job:Job
    @State private var showAddMenu:Bool = false // should be false unless testing
    @State private var newStepField:String = ""
    
    var isAddButtonEnabled:Bool
    {
        !newStepField.isEmpty
    }
    
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
            Text("Add, rename, reorder or delete steps for this\njob. To change the company, "
               + "title or dates, use\nEdit details.")
                .body()
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
                .onMove
                {(sourceIndexSet, destIndex) in
                    job.items.move(fromOffsets: sourceIndexSet, toOffset: destIndex)
                    job.itemCompletion.move(fromOffsets: sourceIndexSet, toOffset: destIndex)
                }
                .frame(width: 360)
            }
            .listStyle(.plain)
            .listRowSpacing(-22)
            Button
            {
                showAddMenu = true
            } label:
            {
                Text("+ Add a step")
                    .font(.button)
                    .foregroundStyle(.brandPrimary)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background
                    {
                        RoundedRectBackground(color: .clear,
                                              cornerRadius: 16,
                                              borderColor: .brandPrimary,
                                              borderWidth: 2,
                                              dash: [6, 4])
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            ToolbarItem(placement: .principal)
            {
                Text("Edit Steps")
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
                ToolbarItem(placement: .topBarTrailing)
                {
                    Text("")
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .sheet(isPresented: $showAddMenu)
        {
            DefaultVStack(alignment: .leading)
            {
                HStack
                {
                    Text("Add a step")
                        .section()
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("New step")
                        .caption()
                    TextField("new step field", text: $newStepField,
                              prompt: Text("Enter new step here"))
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background
                {
                    RoundedRectBackground(color: .backgroundSurface, cornerRadius: 12, borderColor: .borderDefault, borderWidth: 1)
                }
                .focused($focusedField, equals: .newStep)
                Text("This will be added to your checklist")
                    .caption()
                Spacer()
                Button
                {
                    job = job.addItem(newItem: newStepField)
                    newStepField = ""
                    showAddMenu = false
                } label:
                {
                    Text("+ Add")
                        .font(.button)
                        .foregroundStyle(isAddButtonEnabled ? .textOnPrimary : .textDisabled)
                        .padding(.vertical, buttonInternalPadding)
                        .frame(maxWidth: .infinity)
                        .background
                        {
                            RoundedRectBackground(color: isAddButtonEnabled ? .brandPrimary : .stateDisabled, cornerRadius: buttonCornerRadius)
                        }
                }
                .disabled(!isAddButtonEnabled)
            }
            .presentationDetents([.fraction(2 / 5)])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview
{
    @Previewable @State var test:[Job] = [Job(company: "Roblox", title: "Product Designer")]
    EditStepsScreen(NavigationViewModel(), jobs: $test, jobIndex: 0)
}
