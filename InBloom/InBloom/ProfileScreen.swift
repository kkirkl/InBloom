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
            HStack
            {
                Image(systemName: "person.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(Color(white: 0.3))
                    .background(Circle().inset(by: -10).fill(.gray))
            }
            Spacer()
        }
    }
}

#Preview
{
    ProfileScreen()
}
