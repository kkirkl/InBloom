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
    @State private var showEditMenu:Bool = false
    @State private var newItemField:String = ""
    @State private var editItemField:String = ""
    @State private var editedItemOldValue:String = ""
    @State private var editedItemIndex:Int?
    
    var isAddButtonEnabled:Bool
    {
        !newItemField.isEmpty
    }
    
    var isSaveButtonEnabled:Bool
    {
        !editItemField.isEmpty && (editItemField != editedItemOldValue) && (editedItemIndex != nil)
    }
    
    var addOrEditSheet: some View
    {
        DefaultVStack(alignment: .leading)
        {
            HStack
            {
                if showAddMenu
                {
                    Text("Add a step")
                        .section()
                } else if showEditMenu
                {
                    Text("Edit this step")
                        .section()
                } else
                {
                    Text("Error!")
                        .section()
                }
                Spacer()
            }
            VStack(alignment: .leading, spacing: 0)
            {
                if showAddMenu
                {
                    Text("New step")
                        .caption()
                    TextField("new step field", text: $newItemField,
                              prompt: Text("Enter new step here"))
                        .font(.body)
                        .foregroundStyle(.textPrimary)
                } else if showEditMenu
                {
                    Text("Updated step")
                        .caption()
                    TextField("edited step field", text: $editItemField,
                              prompt: Text("Enter updated step here"))
                        .font(.body)
                        .foregroundStyle(.textPrimary)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background
            {
                RoundedRectBackground(color: .backgroundSurface, cornerRadius: 12, borderColor: .borderDefault, borderWidth: 1)
            }
            .focused($focusedField, equals: showAddMenu ? .newStep : .editStep)
            if showAddMenu
            {
                Text("This will be added to your checklist")
                    .caption()
            }
            Spacer()
            Button
            {
                if showAddMenu
                {
                    job = job.addItem(newItem: newItemField)
                    showAddMenu = false
                    newItemField = ""
                } else if showEditMenu
                {
                    if let editedItemIndex
                    {
                        job = job.setItem(at: editedItemIndex, newItem: editItemField)!
                    }
                    showEditMenu = false
                    editedItemIndex = nil
                    editItemField = ""
                }
            } label:
            {
                if showAddMenu
                {
                    Text("+ Add")
                        .foregroundStyle(isAddButtonEnabled ? .textOnPrimary : .textDisabled)
                        .padding(.vertical, buttonInternalPadding)
                        .frame(maxWidth: .infinity)
                        .background
                        {
                            RoundedRectBackground(color: isAddButtonEnabled ?
                                                         .brandPrimary : .stateDisabled,
                                                  cornerRadius: buttonCornerRadius)
                        }
                } else if showEditMenu
                {
                    Text("Save changes")
                        .foregroundStyle(isSaveButtonEnabled ? .textOnPrimary : .textDisabled)
                        .padding(.vertical, buttonInternalPadding)
                        .frame(maxWidth: .infinity)
                        .background
                        {
                            RoundedRectBackground(color: isSaveButtonEnabled ?
                                                         .brandPrimary : .stateDisabled,
                                                  cornerRadius: buttonCornerRadius)
                        }
                }
            }
            .font(.button)
            .disabled(!((showAddMenu && isAddButtonEnabled) !=
                        (showEditMenu && isSaveButtonEnabled)))
        }
        .presentationDetents([.fraction(2 / 5)])
        .presentationDragIndicator(.visible)
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
            Text("Add, rename, reorder or delete steps for this job. To change the company, "
               + "title or dates, use Edit details.")
                .body()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            List
            {
                ForEach(0 ..< job.itemCount(), id: \.self)
                {(index) in
                    HStack
                    {
                        Button
                        {
                            withAnimation(.interactiveSpring)
                            {
                                job = job.removeItem(at: index)!
                            }
                        } label:
                        {
                            Image(systemName: "minus.circle.fill")
                                .font(.section)
                                .foregroundStyle(.stateError)
                        }
                        .buttonStyle(.borderless)
                        Button
                        {
                            editedItemOldValue = job.getItem(at: index) ?? ""
                            editItemField = editedItemOldValue
                            editedItemIndex = index
                            showEditMenu = true
                        } label:
                        {
                            Text(job.getItem(at: index)!)
                                .font(.body)
                                .foregroundStyle(.textPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                        .buttonStyle(.borderless)
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
                    .listRowInsets(.horizontal, 0)
                }
                .onDelete
                {(indexSet) in
                    job = job.removeItems(atOffsets: indexSet)
                }
                .onMove
                {(sourceIndexSet, destIndex) in
                    job = job.moveItems(fromOffsets: sourceIndexSet, toOffset: destIndex)
                }
//                .frame(width: 360)
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
                        RoundedRectBackground(color: .backgroundSurface,
                                              cornerRadius: 16,
                                              borderColor: .brandPrimary,
                                              borderWidth: 2,
                                              dash: [6, 4])
                    }
            }
            Text("Drag the handle to reorder. Tap the red minus to delete a step.")
                .caption()
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
            addOrEditSheet
        }
        .sheet(isPresented: $showEditMenu)
        {
            addOrEditSheet
        }
    }
}

#Preview
{
    @Previewable @State var test:[Job] = [Job(company: "Roblox", title: "Product Designer")]
    EditStepsScreen(NavigationViewModel(), jobs: $test, jobIndex: 0)
}
