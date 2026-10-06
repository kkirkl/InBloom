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
    var body: some View
    {
        VStack
        {
            VStack(alignment: .leading)
            {
                Text("Job Tracker")
                    .font(.system(size: 40))
                Text("Jobs tracked: 0")
                HStack
                {
                    VStack
                    {
                        Text("All")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                            .aspectRatio(1, contentMode: .fill)
                    }
                    .padding(.horizontal, 10)
                    Spacer()
                    VStack
                    {
                        Text("Saved")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                    }
                    Spacer()
                    VStack
                    {
                        Text("In Progress")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                    }
                    Spacer()
                    VStack
                    {
                        Text("Done")
                            .font(tagFont)
                        Text("(0)")
                            .font(tagNumFont)
                    }
                    .padding(6)
                    .overlay
                    {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 3)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
}

#Preview
{
    JobTracker()
}
