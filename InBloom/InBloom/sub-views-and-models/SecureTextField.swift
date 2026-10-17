//
//  SecureTextField.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/15/26.
//  credit to: https://livsycode.com/swiftui/how-to-toggle-secure-input-in-swiftui-textfield/

import SwiftUI

public struct SecureTextField: View
{
    private enum Field: Hashable
    {
        case regular
        case secure
    }
    
    @Binding var text:String
//    @FocusState private var focusedField:Field?
    
    @Binding var isSecure:Bool
    let title:LocalizedStringKey
    let prompt:Text
//    var textContentType:UITextContentType = .password
    
    public init(_ title:LocalizedStringKey, text:Binding<String>, prompt:Text, isSecure:Binding<Bool>)
    {
        self.title = title
        _text = text
        self.prompt = prompt
        _isSecure = isSecure
    }
    
    public var body: some View
    {
        Group
        {
            if isSecure
            {
                secureField()
            } else
            {
                textField()
            }
        }
    }
}

private extension SecureTextField
{
    func textField() -> some View
    {
        TextField(title, text: $text, prompt: prompt)
            .autocorrectionDisabled()
//            .textContentType(textContentType)
            .textInputAutocapitalization(.never)
    }
    
    func secureField() -> some View
    {
        SecureField(title, text: $text, prompt: prompt)
//            .textContentType(textContentType)
    }
}

public extension SecureTextField
{
    func setTextContentType( _ textContentType:UITextContentType) -> some View
    {
        var view = self
//        view.textContentType = textContentType
        return view
    }
}

#Preview
{
//    SecureTextField()
}
