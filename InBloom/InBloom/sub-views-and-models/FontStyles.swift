//
//  FontStyles.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/16/26.
//

import SwiftUI

//let textFieldLabelFont:Font = .system(size: 14)
//let textFieldFont:Font = .system(size: 16)

extension Font
{
    static var screenTitle:Font
    {
        .system(size: 28, weight: .bold)
    }
    
    static var body:Font
    {
        .system(size: 16)
    }
    
    static var button:Font
    {
        .system(size: 16, weight: .semibold)
    }
    
    static var caption:Font
    {
        .system(size: 14)
    }
    
    static var textfield:Font
    {
        .system(size: 16)
    }
}

extension Text
{
    func screenTitle() -> some View
    {
        self.font(.screenTitle).foregroundStyle(.textPrimary)
    }
    
    func body() -> some View
    {
        self.font(.body).foregroundStyle(.textSecondary)
    }
    
    func caption() -> some View
    {
        self.font(.caption).foregroundStyle(.textSecondary)
    }
}

extension TextField
{
    func defaultText() -> some View
    {
        self.font(.body).foregroundStyle(.textPrimary)
    }
}
