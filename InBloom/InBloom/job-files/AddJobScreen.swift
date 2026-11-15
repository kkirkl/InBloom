//
//  AddJobScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct AddJobScreen: View
{
    enum Field:Int, CaseIterable, Hashable
    {
        case company = 0
        case jobTitle = 1
        case location = 2
        case link = 3
        case applicationGoal = 4
        case applicaitonDeadline = 5
        
        var label:String
        {
            switch self
            {
                case .company:
                    "Company"
                case .jobTitle:
                    "Job title"
                case .location:
                    "Location"
                case .link:
                    "Link"
                case .applicationGoal:
                    "Personal deadline"
                case .applicaitonDeadline:
                    "Company deadline"
                    
            }
        }
        
        var prompt:String
        {
            switch self
            {
                case .company:
                    "Company name"
                case .jobTitle:
                    "Job title"
                case .location:
                    "City or remote"
                case .link:
                    "Pase job link"
                case .applicationGoal:
                    "Select date"
                case .applicaitonDeadline:
                    "Select date"
                    
            }
        }
        
        var isRequired:Bool
        {
            switch self
            {
                case .company:
                    true
                case .jobTitle:
                    true
                default:
                    false
            }
        }
    }
    
    // constants
    let companyFieldIndex:Int = 0
    let titleFieldIndex:Int = 1
    let rectCornerRadius:CGFloat = 12
    let rectBorderWidth:CGFloat = 1
    let buttonCornerRadius:CGFloat = 16
    let buttonInternalPadding:CGFloat = 18
    let fieldSpacing:CGFloat = 12
    
    let applicationGoalHint:String = "Your own target date for applying."
    let applicationDeadlineHint:String = "When the company stops accepting applications."
    
    @ObservedObject var navVM:NavigationViewModel
    @Binding var jobs:[Job]
    @FocusState private var focusedField:Int?
    @State private var fieldValues:[String]
    @State private var applicationGoal:Date?
    @State private var applicationDeadline:Date?
    
    var isButtonEnabled:Bool
    {
        !fieldValues[companyFieldIndex].isEmpty && !fieldValues[titleFieldIndex].isEmpty
    }
    
    init(_ navVM:NavigationViewModel, jobs:Binding<[Job]>)
    {
        self.navVM = navVM
        self._jobs = jobs
        self.fieldValues = Array(repeating: "", count: Field.allCases.count)
        self.applicationGoal = nil
        self.applicationDeadline = nil
    }
    
    var body: some View
    {
        DefaultVStack(spacing: 20)
        {
            VStack(spacing: fieldSpacing)
            {
                ForEach(Field.allCases, id: \.self)
                {(field) in
                    VStack(alignment: .leading, spacing: 4)
                    {
                        VStack(alignment: .leading, spacing: 0)
                        {
                            Text("\(field.label) \(field.isRequired ? "*" : "(optional)")")
                                .caption()
                            if field != .applicationGoal && field != .applicaitonDeadline
                            {
                                TextField("\(field.label) field",
                                          text: $fieldValues[field.rawValue],
                                          prompt: Text(field.prompt))
                                .focused($focusedField, equals: field.rawValue)
                                .font(.body)
                                .foregroundStyle(.textPrimary)
                            } else if field == .applicationGoal
                            {
                                CustomDatePicker(date: $applicationGoal)
                                    .foregroundStyle(.textPrimary)
                                    .font(.body)
                            } else if field == .applicaitonDeadline
                            {
                                CustomDatePicker(date: $applicationDeadline)
                                    .foregroundStyle(.textPrimary)
                                    .font(.body)
                            }
                        }
                        .padding(16)
                        .background
                        {
                            RoundedRectBackground(
                                color: .backgroundSurface,
                                cornerRadius: field.rawValue == focusedField ?
                                              (rectCornerRadius + 1) : rectCornerRadius,
                                borderColor: field.rawValue == focusedField ?
                                             .brandPrimary : .borderDefault,
                                borderWidth: rectBorderWidth)
                        }
                        .onTapGesture
                        {
                            focusedField = field.rawValue
                        }
                        Group
                        {
                            if field == .applicationGoal
                            {
                                Text(applicationGoalHint)
                                    .caption()
                            } else if field == .applicaitonDeadline
                            {
                                Text(applicationDeadlineHint)
                                    .caption()
                            }
                        }
                        .padding(.leading, 4)
                    }
                    
                }
            }
            Spacer()
            Button
            {
                var link:String? = fieldValues[Field.link.rawValue]
                link = link!.isEmpty ? nil : link
                var newJob:Job = Job(company: fieldValues[Field.company.rawValue],
                                     title: fieldValues[Field.jobTitle.rawValue], link: link,
                                     applicationGoal: applicationGoal,
                                     applicationDeadline: applicationDeadline)
                jobs.append(newJob)
                navVM.popScreen()
            } label:
            {
                Text("Save job")
                    .font(.button)
                    .foregroundStyle(isButtonEnabled ? .textOnPrimary : .textDisabled)
                    .padding(.vertical, buttonInternalPadding)
                    .frame(maxWidth: .infinity)
                    .background
                    {
                        RoundedRectBackground(color: isButtonEnabled ? .brandPrimary : .stateDisabled, cornerRadius: buttonCornerRadius)
                    }
            }
            .disabled(!isButtonEnabled)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            ToolbarItem(placement: .principal)
            {
                VStack(alignment: .leading, spacing: 0)
                {
                    Text("Add a job")
                        .screenTitle()
                    Text("Fields marked * are required.")
                        .caption()
                }
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
    @Previewable @State var jobs:[Job] = []
    AddJobScreen(NavigationViewModel(), jobs: $jobs)
}
