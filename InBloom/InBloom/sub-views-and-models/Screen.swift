//
//  Screen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

enum Screen: Hashable
{
    case login
    case signup
    case confirmEmail(email:String)
    case emailConfirmed
    case createProfile
    case addJob
    case confirmJobDetails
    case jobDetail(job:Job)
}
