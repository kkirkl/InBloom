//
//  AddJobScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

import SwiftUI

struct AddJobScreen: View
{
    // constants
    let companyFieldIndex:Int = 0
    let titleFieldIndex:Int = 1
    let rectCornerRadius:CGFloat = 12
    let rectBorderWidth:CGFloat = 1
    let buttonCornerRadius:CGFloat = 16
    let buttonInternalPadding:CGFloat = 18
    let fieldSpacing:CGFloat = 12
    
    @FocusState private var focusedField:Int?
    @State private var fieldValues:[String]
    var requiredFields:[Bool]
    let fieldLabels:[String] = ["Company", "Job title", "Location", "Link", "Application date",
                                "Deadline"]
    let fieldPrompts:[String] = ["Company name", "Job title", "City or remote", "Paste job link",
                                 "Select date", "Select date"]
    
    var isButtonEnabled:Bool
    {
        !fieldValues[companyFieldIndex].isEmpty && !fieldValues[titleFieldIndex].isEmpty
    }
    
    init()
    {
        self.fieldValues = Array(repeating: "", count: fieldLabels.count)
        self.requiredFields = Array(repeating: false, count: fieldLabels.count)
        self.requiredFields[companyFieldIndex] = true // company
        self.requiredFields[titleFieldIndex] = true // job title
    }
    
    var body: some View
    {
        DefaultVStack(spacing: 20)
        {
            VStack(alignment: .leading, spacing: 8)
            {
                Text("Add a job")
                    .screenTitle()
                Text("Fields marked * are required.")
                    .caption()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: fieldSpacing)
            {
                ForEach(fieldLabels.indices, id: \.self)
                {(index) in
                    VStack(alignment: .leading, spacing: 0)
                    {
                        // "[field label] ["*" if required]"
                        Text("\(fieldLabels[index]) \(requiredFields[index] ? "*" : "")")
                            .caption()
                        TextField("\(fieldLabels[index]) field",
                                  text: $fieldValues[index],
                                  prompt: Text(fieldPrompts[index]))
                            .focused($focusedField, equals: index)
                    }
                    .padding(16)
                    .background
                    {
                        RoundedRectBackground(
                            color: .backgroundSurface,
                            cornerRadius: index == focusedField ?
                                          (rectCornerRadius + 1) : rectCornerRadius,
                            borderColor: index == focusedField ? .brandPrimary : .borderDefault,
                            borderWidth: rectBorderWidth)
                    }
                }
            }
            Spacer()
            Button
            {
                
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
        }
    }
}

#Preview
{
    AddJobScreen()
}
