//
//  JobFilter.swift
//  InBloom
//
//  Created by Kirkland, Kaden E on 10/20/26.
//

enum JobFilter: CaseIterable, Hashable
{
    case saved
    case inProgress
    case done
    
    var description:String
    {
        switch self
        {
            case .saved:
                "Saved"
            case .inProgress:
                "In progress"
            case .done:
                "Done"
        }
    }
    
    var filterFunction: (Job) -> Bool
    {
        switch self
        {
            case .saved:
                {job in job.isSaved}
            case .inProgress:
                {job in !job.isCompleted}
            case .done:
                {job in job.isCompleted}
        }
    }
}
