//
//  Action.swift
//  TimeTracker
//
//  Created by Zafar on 12/2/19.
//  Copyright © 2019 Zafar. All rights reserved.
//

import RealmSwift

extension Realm {
    func addProject(_ name: String) {
        do {
            try write {
                let project = Project()
                project.name = name
                add(project)
            }
        } catch {
            print("Add Project action failed: \(error)")
        }
   }
    
    func deleteProject(_ project: Project) {
        do {
            try write {
                delete(project.activities)
                delete(project)
            }
        } catch {
            print("Delete Project action failed: \(error)")
        }
    }
    
    func startActivity(_ project: Project, startDate: NSDate) {
        do {
            try write {
                let act = Activity()
                act.startDate = startDate as Date
                project.activities.append(act)
            }
        } catch {
            print("Start Activity action failed: \(error)")
        }
    }
    
    func endActivity(_ project: Project, endDate: NSDate) {
        guard let activity = project.currentActivity else { return }
        
        do {
            try write {
                activity.endDate = endDate as Date
            }
        } catch {
            print("End Activity action failed: \(error)")
        }
     }

}
