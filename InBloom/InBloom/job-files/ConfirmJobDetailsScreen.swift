//
//  ConfirmJobDetailsScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

struct ConfirmJobDetailsScreen: View
{
    @ObservedObject var navVM:NavigationViewModel
    @State private var company:String = ""
    // parallel arrays
    @State private var fields:[String] = ["", "", "", ""]
    let labels:[String] = ["Company", "Job title", "Location", "Link"]
    
    
    let rectCornerRadius:CGFloat = 12
    var body: some View
    {
        DefaultVStack
        {
            VStack(alignment: .leading, spacing: 10)
            {
                Text("Check the detials")
                    .screenTitle()
                Text("Fields marked Fill are for you to add.")
                    .caption()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
            VStack(spacing: 12)
            {
                ForEach(fields.indices, id: \.self)
                {(index) in
                    VStack(alignment: .leading, spacing: 0)
                    {
                        Text(labels[index])
                            .caption()
                        TextField("\(labels[index]) field", text: $fields[index], prompt: Text(labels[index]))
                            .defaultText()
                            .textInputAutocapitalization(.never)
                    }
                    .padding(16)
                    .background
                    {
                        RoundedRectBackground(color: .backgroundSurface,
                                              cornerRadius: rectCornerRadius,
                                              borderColor: .borderDefault,
                                              borderWidth: 1)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Check the details")
    }
}

#Preview
{
    ConfirmJobDetailsScreen(navVM: NavigationViewModel())
}
