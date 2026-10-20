//
//  Job.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import Foundation

struct Job: Hashable
{
    var company:String
    var title:String
    var items:[String] = [] // TODO maybe have default items
    var itemCompletion:[Bool] = []
    var isSaved:Bool = false
    var deadline:Date?
    var link:String?
    var isCompleted:Bool
    {
        for status in itemCompletion
        {
            if !status
            {
                return false
            }
        }
        return true
    }
    
    func addItem(newItem:String) -> Job
    {
        var newItems:[String] = items
        var newCompletions:[Bool] = itemCompletion
        newItems.append(newItem)
        newCompletions.append(false)
        
        return Job(company: company, title: title, items: newItems, itemCompletion: newCompletions,
                   isSaved: isSaved, deadline: deadline, link: link)
    }
    
    func toggleItem(itemIndex:Int) -> Job?
    {
        guard itemIndex < items.count else {return nil}
        
        // should always be parallel with items, so it's safe to unwrap
        var newCompletions:[Bool] = itemCompletion
        newCompletions[itemIndex].toggle()
        return Job(company: company, title: title, items: items, itemCompletion: newCompletions,
                   isSaved: isSaved, deadline: deadline, link: link)
    }
    
    func completedItems() -> Int
    {
        var numOfItems:Int = 0
        for i in 0 ..< itemCompletion.count
        {
            numOfItems += itemCompletion[i] ? 1 : 0
        }
        return numOfItems
    }
    
    func toggledSaved() -> Job
    {
        return Job(company: company, title: title, items: items, itemCompletion: itemCompletion,
                   isSaved: !isSaved, deadline: deadline, link: link)
    }
    
    static func getJobDeadlineString(date:Date) -> String
    {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}
