//
//  MainView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct MainView: View
{
    var body: some View
    {
        TabView
        {
            Tab("", systemImage: "list.clipboard")
            {
                JobTracker()            }
            Tab("", systemImage: "leaf.fill")
            {
                Text("[beautiful garden here :D]")
                    .font(.system(size: 30))
            }
            Tab("", systemImage: "person.circle")
            {
                Text("[your profile here!]")
                    .font(.system(size: 30))
            }
        }
        .tint(.green)
    }
}

#Preview
{
    MainView()
}
