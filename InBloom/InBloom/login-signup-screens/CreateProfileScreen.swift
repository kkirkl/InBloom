//
//  CreateProfileScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

let personIconColor:Color = Color(red: 0.3, green: 0.3, blue: 0.3)

let placeholderDropdownIcon:Image = Image(systemName: "arrowtriangle.down.fill")

struct CreateProfileScreen: View
{
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var username:String = ""
    @State private var university:String = ""
    
    var body: some View
    {
        VStack
        {
            VStack
            {
                ZStack
                {
                    Circle()
                        .fill(Color(white: 0.8))
                        .stroke(personIconColor, lineWidth: 2.5)
                    Image(systemName: "person.fill")
                        .font(.system(size: 100))
                        .foregroundStyle(personIconColor)
                    VStack
                    {
                        Spacer()
                        HStack
                        {
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(.green)
                                .background()
                                .clipShape(Circle().inset(by: 4))
                        }
                    }
                }
                .frame(width: 140, height: 140)
                .padding(.top, 5)
                Text("Add profile picture")
                    .font(.system(size: 20))
            }
            Spacer()
            VStack(spacing: 15)
            {
                TextField("First Name", text: $firstName, prompt: Text("First Name"))
                    .font(.system(size: 25))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
                TextField("Last Name", text: $lastName, prompt: Text("Last Name"))
                    .font(.system(size: 25))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
                TextField("Username", text: $username, prompt: Text("Username"))
                    .font(.system(size: 25))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
                TextField("University", text: $university, prompt: Text("\(placeholderDropdownIcon)University"))
                    .font(.system(size: 25))
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.gray))
            }
            Spacer()
            Spacer()
            Button("Continue")
            {
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .font(.system(size: 25))
            .tint(.green)
            .frame(width: 250)
            .padding(.bottom, 50)
        
        }
        .padding(.horizontal, 30)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview
{
    CreateProfileScreen()
}
