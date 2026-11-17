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

@Observable class Job: Identifiable
{
    static func == (lhs: borrowing Job, rhs: borrowing Job) -> Bool
    {
        lhs.id == rhs.id
    }
    
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
        if itemCompletion.count != items.count
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
    
    func setCompany(newCompany:String)
    {
        company = newCompany
    }
    
    func getTitle() -> String
    {
        return title
    }
    
    func setTitle(newTitle:String)
    {
        title = newTitle
    }
    
    func getItem(at itemIndex:Int) -> String?
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return nil}
        return items[itemIndex]
    }
    
    func setItem(at itemIndex:Int, newItem:String)
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return}
        items[itemIndex] = newItem
    }
    
    func addItem(newItem:String)
    {
        items.append(newItem)
        itemCompletion.append(false)
    }
    
    func removeItem(at itemIndex:Int)
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return}
        
        items.remove(at: itemIndex)
        itemCompletion.remove(at: itemIndex)
        
    }
    
    func removeItems(atOffsets offsets:IndexSet)
    {
        items.remove(atOffsets: offsets)
        itemCompletion.remove(atOffsets: offsets)
    }
    
    func moveItems(fromOffsets:IndexSet, toOffset:Int)
    {
        items.move(fromOffsets: fromOffsets, toOffset: toOffset)
        itemCompletion.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func isItemComplete(itemIndex:Int) -> Bool?
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return nil}
        return itemCompletion[itemIndex]
    }
    
    func toggleItem(at itemIndex:Int)
    {
        guard 0 <= itemIndex && itemIndex < items.count else {return}
        itemCompletion[itemIndex].toggle()
    }
    
    func isSaved() -> Bool
    {
        return saved
    }
    
    func toggleSaved()
    {
        saved.toggle()
    }
    
    func getLink() -> String?
    {
        return link
    }
    
    func setLink(newLink:String)
    {
        link = newLink
    }
    
    func getApplicationGoal() -> Date?
    {
        return applicationGoal
    }
    
    func setApplicationGoal(newGoal:Date)
    {
        applicationGoal = newGoal
    }
    
    func getApplicationDeadline() -> Date?
    {
        return applicationDeadline
    }
    
    func setApplicationDeadline(newDeadline:Date)
    {
       applicationDeadline = newDeadline
    }
}
