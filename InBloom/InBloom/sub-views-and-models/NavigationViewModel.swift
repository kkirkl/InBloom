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
    @Published var path:NavigationPath = NavigationPath()
    
    func pushScreen(screen:Screen)
    {
        path.append(screen)
    }
    
    func pushJobDetail(index:Int)
    {
        path.append(Screen.jobDetail(jobIndex: index))
    }
    
    func pushEditSteps(index:Int)
    {
        path.append(Screen.editSteps(jobIndex: index))
    }
    
    func popScreen()
    {
        path.removeLast()
    }
}
