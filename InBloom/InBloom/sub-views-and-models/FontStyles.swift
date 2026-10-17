//
//  FontStyles.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

extension Font
{
    static var screenTitle:Font
    {
        .system(size: 28, weight: .bold)
    }
    
    static var subtitle:Font
    {
        .system(size: 16)
    }
    
    static var button:Font
    {
        .system(size: 18, weight: .semibold)
    }
}

extension Text
{
    func screenTitle() -> some View
    {
        self.font(.screenTitle).foregroundStyle(.textPrimary)
    }
    
    func subtitle() -> some View
    {
        self.font(.subtitle).foregroundStyle(.textSecondary)
    }
}
