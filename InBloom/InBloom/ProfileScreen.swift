//
//  ProfileScreen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct ProfileScreen: View
{
    var body: some View
    {
        VStack
        {
            HStack(alignment: .top)
            {
                Image(systemName: "person.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(Color(white: 0.3))
                    .background(Circle().inset(by: -10).fill(.gray))
                    .padding(.leading, 10)
                    .padding(.trailing, 15)
                VStack(alignment: .leading)
                {
                    Text("Example User")
                        .font(.system(size: 35))
                    Text("UT Austin")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(white: 0.4))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal, 15)
    }
}

#Preview
{
    ProfileScreen()
}
