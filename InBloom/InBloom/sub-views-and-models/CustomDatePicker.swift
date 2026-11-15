//
//  CustomDatePicker.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 11/14/26.
//

import SwiftUI

struct CustomDatePicker: View
{
    @Binding private var date:Date?
    let prompt:String
    
    init(date:Binding<Date?>, prompt:String = "Select date")
    {
        self._date = date
        self.prompt = prompt
    }

    var body: some View
    {
        HStack
        {
            if date == nil
            {
                Text(prompt)
                    .foregroundStyle(.textDisabled)
                    .overlay
                {
                    DatePicker("date", selection: Binding<Date>(get: {self.date ?? Date()},
                                                                set: {self.date = $0}),
                               displayedComponents: [.date])
                    .colorMultiply(.clear)
                }
            } else
            {
                Text(date!, format: .dateTime.day().year().month(.wide))
                    .overlay
                {
                    DatePicker("date", selection: Binding<Date>(get: {self.date ?? Date()},
                                                                set: {self.date = $0}),
                               displayedComponents: [.date])
                    .colorMultiply(.clear)
                }
            }
            Spacer()
            Button
            {
                date = nil
            } label:
            {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.textDisabled)
            }
        }
    }
}

#Preview
{
    @Previewable @State var date1:Date? = nil
    @Previewable @State var date2:Date? = Date()
    DefaultVStack
    {
        CustomDatePicker(date: $date1)
        CustomDatePicker(date: $date2)
    }
}
