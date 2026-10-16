//
//  SecureTextField.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/15/26.
// credit to: https://livsycode.com/swiftui/how-to-toggle-secure-input-in-swiftui-textfield/

import SwiftUI

public struct SecureTextField: View
{
    private enum Field: Hashable
    {
        case regular, secure
    }
    
    @Binding private var text:String
    private let isSecureTextEntry:Bool
    
    @FocusState private var focusedField:Field?
    
    private let title:LocalizedStringKey
    private var textContentType:UITextContentType = .password
    
    public init(_ title:LocalizedStringKey, text:Binding<String>, isSecure:Bool)
    {
        self.title = title
        _text = text
        isSecureTextEntry = isSecure
    }
    
    public var body: some View
    {
        Group
        {
            if isSecureTextEntry
            {
                secureField()
            } else
            {
                textField()
            }
        }
        .onChange(of: isSecureTextEntry)
        {(_, newValue) in
            focusedField = isSecureTextEntry ? .secure : .regular
        }
    }
}

private extension SecureTextField
{
    func textField() -> some View
    {
        TextField(title, text: $text)
            .focused($focusedField, equals: .regular)
            .autocorrectionDisabled()
            .textContentType(textContentType)
    }
    
    func secureField() -> some View
    {
        SecureField(title, text: $text)
            .focused($focusedField, equals: .secure)
            .textContentType(textContentType)
    }
}

public extension SecureTextField
{
    func setTextContentType( _ textContentType: UITextContentType) -> some View
    {
        var view = self
        view.textContentType = textContentType
        return view
    }
}

#Preview
{
//    SecureTextField()
}
