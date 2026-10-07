//
//  MainView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

struct MainView: View
{
    @StateObject var jobNavVM:NavigationViewModel = NavigationViewModel()
    @StateObject var gardenNavVM:NavigationViewModel = NavigationViewModel()
    @StateObject var profileNavVM:NavigationViewModel = NavigationViewModel()
    var body: some View
    {
        TabView
        {
            Tab("", systemImage: "list.clipboard")
            {
                NavigationStack(path: $jobNavVM.path)
                {
                    JobTracker(navVM: jobNavVM)
                        .navigationDestination(for: Screen.self)
                    {(screen) in
                        switch screen
                        {
                            case .jobDetail(let job):
                                JobDetailScreen(job: job)
                            default:
                                self
                        }
                    }
                }
            }
            Tab("", systemImage: "leaf.fill")
            {
                NavigationStack(path: $gardenNavVM.path)
                {
                    GardenScreen(navVM: gardenNavVM)
                }
            }
            Tab("", systemImage: "person.circle")
            {
                NavigationStack(path: $profileNavVM.path)
                {
                    ProfileScreen(navVM: profileNavVM)
                }
            }
        }
        .tint(.green)
    }
}

#Preview
{
    MainView()
}
