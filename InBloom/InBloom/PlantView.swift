//
//  PlantView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/13/26.
//

import SwiftUI

struct PlantView: View
{
    var body: some View
    {
        VStack
        {
            VStack(spacing: 10)
            {
                Text("Your garden is empty")
                    .foregroundStyle(.textPrimary)
                    .font(.system(size: 20, weight: .semibold))
                Text("Add a job in Job Tracker to plant your first seed.")
                    .foregroundStyle(.textSecondary)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 300)
            Spacer()
        }
    }
}

#Preview {
    PlantView()
}
