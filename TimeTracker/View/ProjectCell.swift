//
//  ProjectCell.swift
//  TimeTracker
//
//  Created by Zafar on 12/2/19.
//  Copyright © 2019 Zafar. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var elapsedTimeLabel: UILabel!
    @IBOutlet var activityButton: UIButton!
    
     var project: Project? {
           didSet {
               guard let project = project else { return }
               nameLabel.text = project.name
               if project.currentActivity != nil {
                   elapsedTimeLabel.text = "⌚️"
                activityButton.setTitle("Stop", for: UIControl.State())
               } else {
                   elapsedTimeLabel.text = DateComponentsFormatter().string(from: project.elapsedTime)
                activityButton.setTitle("Start", for: UIControl.State())
               }
           }
       }
    
    @IBAction func activityButtonTapped() {
         guard let project = project else { return }
               if project.currentActivity == nil {
                   store.startActivity(project, startDate: Date() as NSDate)
               } else {
                   store.endActivity(project, endDate: Date() as NSDate)
               }
    }
}
