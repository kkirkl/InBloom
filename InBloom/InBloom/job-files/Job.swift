//
//  Job.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import Foundation

func filteredJobs(_ jobs:[Job], filter:JobFilter) -> [Job]
{
    var savedJobs:[Job] = []
    for job in jobs
    {
        if filter.filterFunction(job)
        {
            savedJobs.append(job)
        }
    }
    return savedJobs
}

struct Job: Hashable
{
    static let defaultItems:[String] = ["Research company", "Tailor resume", "Write/review cover letter", "Email hiring manager"]
    
    var company:String
    var title:String
    var items:[String]
    var itemCompletion:[Bool]
    var isSaved:Bool
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
    var completedCount:Int
    {
        var numOfItems:Int = 0
        for i in 0 ..< itemCompletion.count
        {
            numOfItems += itemCompletion[i] ? 1 : 0
        }
        return numOfItems
    }
    var nextItem:String?
    {
        for i in items.indices
        {
            if !itemCompletion[i]
            {
                return items[i]
            }
        }
        return nil
    }
    
    init(company:String, title:String, items:[String] = defaultItems, itemCompletion:[Bool] = [],
         isSaved:Bool = false, deadline:Date? = nil, link:String? = nil, isCompleted:Bool = false)
    {
        self.company = company
        self.title = title
        self.items = items
        self.itemCompletion = itemCompletion
        if self.itemCompletion.count != self.items.count
        {
            self.itemCompletion = Array(repeating: false, count: items.count)
        }
        self.isSaved = isSaved
        self.deadline = deadline
        self.link = link
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
