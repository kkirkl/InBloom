//
//  Job.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/6/26.
//

import Foundation
import SwiftUI

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

struct Job: Hashable, Identifiable
{
    static let defaultItems:[String] = ["Research company", "Tailor resume",
                                        "Write/review cover letter", "Email hiring manager"]
    
    var id:UUID = UUID()
    private var company:String
    private var title:String
    private var items:[String]
    private var itemCompletion:[Bool]
    private var saved:Bool
    private var link:String?
    private var applicationGoal:Date?
    private var applicationDeadline:Date?
    private var stageIndex:Int
    {
        let items:Int = itemCount()
        if items == 0
        {
            return 0
        }
        
        let completed:Int = completedCount()
        if completed == items
        {
            return PlantStage.allCases.count - 1
        }
        
        let stepSize:Double = Double(1) / Double(PlantStage.allCases.count - 1)
        let percentage:Double = Double(completed) / Double(items)
        return Int(floor(percentage / stepSize))
    }
    
    init(company:String, title:String, items:[String] = defaultItems, itemCompletion:[Bool] = [],
         isSaved:Bool = false, link:String? = nil, applicationGoal:Date? = nil,
         applicationDeadline:Date? = nil)
    {
        self.company = company
        self.title = title
        self.items = items
        self.itemCompletion = itemCompletion
        if self.itemCompletion.count != self.items.count
        {
            self.itemCompletion = Array(repeating: false, count: items.count)
        }
        self.saved = isSaved
        self.applicationGoal = applicationGoal
        self.applicationDeadline = applicationDeadline
        self.link = link
    }
    
    func isCompleted() -> Bool
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
    
    func itemCount() -> Int
    {
        return items.count
    }
    
    func completedCount() -> Int
    {
        var numOfItems:Int = 0
        for i in 0 ..< itemCompletion.count
        {
            numOfItems += itemCompletion[i] ? 1 : 0
        }
        return numOfItems
    }
    
    func nextItem() -> String?
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
    
    func plantStage() -> PlantStage
    {
        return PlantStage.allCases[stageIndex]
    }
    
    func completionPercentage() -> Double
    {
        let completed:Int = completedCount()
        let items:Int = itemCount()
        if completed == items
        {
            return 1
        }
        return Double(completed) / Double(items)
    }
    
    func itemsTillNextStage() -> Int
    {
        let completed:Int = completedCount()
        let items:Int = itemCount()
        if completed == items
        {
            return 0
        }
        let nextStagePercentage:Double =
            Double(stageIndex + 1) / Double(PlantStage.allCases.count - 1)
        let neededItems:Int = Int(ceil(nextStagePercentage * Double(items)))
        return neededItems - completed
    }
    
    func getCompany() -> String
    {
        return company
    }
    
    func setCompany(newCompany:String) -> Job
    {
        return Job(company: newCompany, title: title, items: items, itemCompletion: itemCompletion,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func getTitle() -> String
    {
        return title
    }
    
    func setTitle(newTitle:String) -> Job
    {
        return Job(company: company, title: newTitle, items: items, itemCompletion: itemCompletion,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func getItem(at itemIndex:Int) -> String?
    {
        guard itemIndex < items.count else {return nil}
        return items[itemIndex]
    }
    
    func setItem(at itemIndex:Int, newItem:String) -> Job?
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return nil}
        
        var newItems:[String] = items
        newItems[itemIndex] = newItem
        return Job(company: company, title: title, items: newItems, itemCompletion: itemCompletion,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func addItem(newItem:String) -> Job
    {
        var newItems:[String] = items
        var newCompletions:[Bool] = itemCompletion
        newItems.append(newItem)
        newCompletions.append(false)
        
        return Job(company: company, title: title, items: newItems, itemCompletion: newCompletions,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func removeItem(at itemIndex:Int) -> Job?
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return nil}
        
        var newItems:[String] = items
        var newCompleted:[Bool] = itemCompletion
        newItems.remove(at: itemIndex)
        newCompleted.remove(at: itemIndex)
        return Job(company: company, title: title, items: newItems, itemCompletion: newCompleted,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
        
    }
    
    func removeItems(atOffsets offsets:IndexSet) -> Job
    {
        var newItems:[String] = items
        var newCompleted:[Bool] = itemCompletion
        newItems.remove(atOffsets: offsets)
        newCompleted.remove(atOffsets: offsets)
        return Job(company: company, title: title, items: newItems, itemCompletion: newCompleted,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func moveItems(fromOffsets:IndexSet, toOffset:Int) -> Job
    {
        var newItems:[String] = items
        var newCompleted:[Bool] = itemCompletion
        newItems.move(fromOffsets: fromOffsets, toOffset: toOffset)
        newCompleted.move(fromOffsets: fromOffsets, toOffset: toOffset)
        return Job(company: company, title: title, items: newItems, itemCompletion: newCompleted,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func isItemComplete(itemIndex:Int) -> Bool?
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return nil}
        return itemCompletion[itemIndex]
    }
    
    func itemToggled(at itemIndex:Int) -> Job?
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return nil}
        
        // should always be parallel with items, so it's safe to unwrap
        var newCompletions:[Bool] = itemCompletion
        newCompletions[itemIndex].toggle()
        return Job(company: company, title: title, items: items, itemCompletion: newCompletions,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func isSaved() -> Bool
    {
        return saved
    }
    
    func savedToggled() -> Job
    {
        return Job(company: company, title: title, items: items, itemCompletion: itemCompletion,
                   isSaved: !saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func getLink() -> String?
    {
        return link
    }
    
    func setLink(newLink:String) -> Job
    {
        return Job(company: company, title: title, items: items, itemCompletion: itemCompletion,
                   isSaved: saved, link: newLink, applicationGoal: applicationGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func getApplicationGoal() -> Date?
    {
        return applicationGoal
    }
    
    func setApplicationGoal(newGoal:Date) -> Job
    {
        return Job(company: company, title: title, items: items, itemCompletion: itemCompletion,
                   isSaved: saved, link: link, applicationGoal: newGoal,
                   applicationDeadline: applicationDeadline)
    }
    
    func getApplicationDeadline() -> Date?
    {
        return applicationDeadline
    }
    
    func setApplicationDeadline(newDeadline:Date) -> Job
    {
        return Job(company: company, title: title, items: items, itemCompletion: itemCompletion,
                   isSaved: saved, link: link, applicationGoal: applicationGoal,
                   applicationDeadline: newDeadline)
    }
}
