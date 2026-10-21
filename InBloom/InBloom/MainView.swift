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
    @State private var jobs:[Job] = [Job(company: "Roblox", title: "Product Designer")]
    @State private var currentTab:TabScreen = .garden
    @StateObject var jobNavVM:NavigationViewModel = NavigationViewModel()
    @StateObject var gardenNavVM:NavigationViewModel = NavigationViewModel()
    @StateObject var profileNavVM:NavigationViewModel = NavigationViewModel()
    
    var body: some View
    {
        TabView(selection: $currentTab)
        {
            Tab("", systemImage: "list.clipboard", value: .jobs) // job tracker
            {
                NavigationStack(path: $jobNavVM.path)
                {
                    JobTracker(jobNavVM, jobs: $jobs)
                        .navigationDestination(for: Screen.self)
                    {(screen) in
                        switch screen
                        {
                            case .addJob:
                                AddJobScreen(jobNavVM, jobs: $jobs)
                            case let .jobDetail(jobIndex):
                                JobDetailScreen(jobNavVM, jobs: $jobs, jobIndex: jobIndex)
                            case .confirmJobDetails:
                                ConfirmJobDetailsScreen(navVM: jobNavVM)
                            default:
                                self
                        }
                    }
                }
            }
            Tab("", systemImage: "leaf.fill", value: .garden) // garden
            {
                NavigationStack(path: $gardenNavVM.path)
                {
                    GardenScreen(navVM: gardenNavVM)
                }
            }
            Tab("", systemImage: "person.circle", value: .profile) // profile
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
