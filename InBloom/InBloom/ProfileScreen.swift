//
//  ProfileScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct ProfileScreen: View
{
    let screenTitleFont:Font = .system(size: 32, weight: .bold)
    let initialsFont:Font = .system(size: 40, weight: .bold)
    let fullNameFont:Font = .system(size: 22, weight: .semibold)
    let usernameFont:Font = .system(size: 16)
    let textFieldFont:Font = .system(size: 18.5)
    let searchButtonFont:Font = .system(size: 18.5, weight: .semibold)
    let rectangleCornerRadius:CGFloat = 16
    let rectangleBorderWidth:CGFloat = 1
    
    var profileRectBackground: some View
    {
        RoundedRectBackground(color: .backgroundSurface,
                              cornerRadius: rectangleCornerRadius,
                              borderColor: .borderDefault,
                              borderWidth: rectangleBorderWidth)
    }
    
    @ObservedObject var navVM:NavigationViewModel
    @State private var exampleProfile:Profile = Profile(firstname: "Jordan", lastName: "Lee",
                                                        username: "jordanlee",
                                                        university: "UT Austin",
                                                        applicationsUnfinished: 2,
                                                        applicationsFinished: 1)
    @State private var usernameField:String = ""
    
    var body: some View
    {
        ZStack(alignment: .leading)
        {
            Color(.backgroundDefault)
                .ignoresSafeArea()
            VStack(alignment: .leading)
            {
                Text("Profile")
                    .font(screenTitleFont)
                    .foregroundStyle(.textPrimary)
                VStack
                {
                    Text(exampleProfile.initials)
                        .frame(width: 100, height: 100)
                        .font(initialsFont)
                        .foregroundStyle(.brandPrimary)
                        .background
                        {
                            Circle()
                                .fill(.brandPrimaryLight)
                        }
                    Text(exampleProfile.fullName)
                        .foregroundStyle(.textPrimary)
                        .font(fullNameFont)
                    Text("@\(exampleProfile.username) · \(exampleProfile.university)")
                        .font(usernameFont)
                        .foregroundStyle(.textSecondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)
                HStack(spacing: 4)
                {
                    VStack(alignment: .leading)
                    {
                        Text("\(exampleProfile.applicationsFinished)")
                            .font(screenTitleFont)
                            .foregroundStyle(.textPrimary)
                        Text("Plant\(exampleProfile.applicationsFinished == 1 ? "" : "s") grown")
                            .font(usernameFont)
                            .foregroundStyle(.textSecondary)
                    }
                    .padding(15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background
                    {
                        profileRectBackground
                    }
                    Spacer()
                    VStack(alignment: .leading)
                    {
                        Text("\(exampleProfile.applicationsUnfinished)")
                            .font(screenTitleFont)
                            .foregroundStyle(.textPrimary)
                        Text("Bloomed")
                            .font(usernameFont)
                            .foregroundStyle(.textSecondary)
                    }
                    .padding(15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background
                    {
                        profileRectBackground
                    }
                }
                .padding(.bottom, 14)
                VStack(alignment: .leading, spacing: 6)
                {
                    Text("Add a friend")
                        .foregroundStyle(.textPrimary)
                        .font(fullNameFont)
                    HStack
                    {
                        VStack(alignment: .leading, spacing: 2)
                        {
                            Text("Find a friend by username")
                                .font(usernameFont)
                                .foregroundStyle(.textSecondary)
                            TextField("username search field", text: $usernameField,
                                      prompt: Text("Search by username"))
                            .font(textFieldFont)
                            .foregroundStyle(.textPrimary)
                            .textInputAutocapitalization(.never)
                        }
                        Button("Search")
                        {
                            //TODO
                        }
                        .font(searchButtonFont)
                        .foregroundStyle(.brandPrimary)
                    }
                    .padding(18)
                    .background
                    {
                        profileRectBackground
                    }
                    Text("Type their username, then tap Search.")
                        .font(usernameFont)
                        .foregroundStyle(.textSecondary)
                        .padding(.leading, 8)
                }
                .padding(.bottom, 14)
                VStack(alignment: .leading, spacing: 14)
                {
                    Text("Friends (0)")
                        .font(fullNameFont)
                        .foregroundStyle(.textPrimary)
                    Text("No friends yet.")
                        .font(textFieldFont)
                        .foregroundStyle(.textSecondary)
                }
                Button
                {
                    
                } label:
                {
                    HStack
                    {
                        Image(systemName: "play.circle")
                            .foregroundStyle(.brandPrimary)
                            .font(.system(size: 22))
                        Text("Replay tutorial")
                            .font(textFieldFont)
                            .foregroundStyle(.textPrimary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.brandPrimary)
                    }
                    .padding(16)
                    .background
                    {
                        profileRectBackground
                    }
                }
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
