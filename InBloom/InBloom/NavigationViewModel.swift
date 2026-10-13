//
//  NavigationViewModel.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import Foundation
import SwiftUI
import Combine


class NavigationViewModel: ObservableObject
{
    @Published var path = NavigationPath()
    
    func pushScreen(screen:Screen)
    {
        path.append(screen)
    }
    
    func pushJobDetail(job:Job)
    {
        path.append(Screen.jobDetail(job: job))
    }
}
