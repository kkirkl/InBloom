//
//  InBloomApp.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 9/28/26.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey:Any]? = nil) -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}

@main
struct InBloomApp: App
{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
    }
}
