//
//  ProfileScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct ProfileScreen: View
{
    @ObservedObject var navVM:NavigationViewModel
    @State private var exampleProfile:Profile = Profile(firstname: "Jordan", lastName: "Lee",
                                                        username: "jordanlee",
                                                        university: "UT Austin")
    var body: some View
    {
        ZStack(alignment: .leading)
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack(alignment: .leading)
            {
                Text("Profile")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.textPrimary)
                VStack
                {
                    Text(exampleProfile.initials)
                        .frame(width: 100, height: 100)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.brandPrimary)
                        .background
                        {
                            Circle()
                                .fill(.brandPrimaryLight)
                        }
                    Text(exampleProfile.fullName)
                        .foregroundStyle(.textPrimary)
                        .font(.system(size: 24, weight: .semibold))
                    Text("@\(exampleProfile.username) · \(exampleProfile.university)")
                        .font(.system(size: 18))
                        .foregroundStyle(.textSecondary)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview
{
    ProfileScreen(navVM: NavigationViewModel())
}
