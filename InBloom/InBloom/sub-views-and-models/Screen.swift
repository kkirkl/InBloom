//
//  Screen.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

enum Screen: Hashable
{
    case login
    case signup
    case confirmEmail(email:String)
    case emailConfirmed
    case createProfile
    case jobDetail(job:Job)
}
