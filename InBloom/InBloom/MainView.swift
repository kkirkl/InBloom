//
//  MainView.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import SwiftUI

enum TabScreen
{
    case jobs
    case garden
    case profile
}

struct MainView: View
{
    @State private var currentTab:TabScreen = .garden
    @StateObject var jobNavVM:NavigationViewModel = NavigationViewModel()
    @StateObject var gardenNavVM:NavigationViewModel = NavigationViewModel()
    @StateObject var profileNavVM:NavigationViewModel = NavigationViewModel()
    
    var body: some View
    {
        TabView(selection: $currentTab)
        {
            Tab("", systemImage: "list.clipboard", value: .jobs)
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
            Tab("", systemImage: "leaf.fill", value: .garden)
            {
                NavigationStack(path: $gardenNavVM.path)
                {
                    GardenScreen(navVM: gardenNavVM)
                }
            }
            Tab("", systemImage: "person.circle", value: .profile)
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
