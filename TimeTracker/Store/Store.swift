//
//  Store.swift
//  TimeTracker
//
//  Created by Zafar on 12/2/19.
//  Copyright © 2019 Zafar. All rights reserved.
//

import Foundation
import RealmSwift

class Project: Object {
    @objc dynamic var name: String = ""
    let activities = List<Activity>()
}

class Activity: Object {
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
}

extension Project {
    var elapsedTime: TimeInterval {
        return activities.reduce(0) { time, activity in
            guard let start = activity.startDate,
                let end = activity.endDate else { return time }
            return time + end.timeIntervalSince(start)
        }
    }
    
    var currentActivity: Activity? {
        return activities.filter("endDate == nil").first
    }
}

// MARK: Application/View state
extension Realm {
    var projects: Results<Project> {
        return objects(Project.self)
    }
}

//MARK: - Single global instance of store.
let store = try! Realm()
