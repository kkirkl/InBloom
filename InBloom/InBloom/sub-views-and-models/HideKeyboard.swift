//
//  HideKeyboard.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 11/14/26.
//

import SwiftUI

extension View
{
    func hideKeyboard()
    {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,
                                        from: nil, for: nil)
    }
}
