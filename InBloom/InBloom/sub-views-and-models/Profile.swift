//
//  Profile.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import Foundation

struct Profile
{
    var firstname:String
    var lastName:String
    var username:String
    var university:String //TODO might want this to be something else later
    var applicationsUnfinished:Int = 0
    var applicationsFinished:Int = 0
    
    var fullName:String
    {
        "\(firstname) \(lastName)"
    }
    
    var initials:String
    {
        firstname.prefix(1).uppercased() + lastName.prefix(1).uppercased()
    }
}
