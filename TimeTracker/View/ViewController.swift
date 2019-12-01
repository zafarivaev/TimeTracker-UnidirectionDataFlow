//
//  ViewController.swift
//  TimeTracker
//
//  Created by Zafar on 12/2/19.
//  Copyright © 2019 Zafar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    @IBOutlet weak var newProjectTextField: UITextField!
    let projects = store.projects
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        notificationToken = store.observe { [unowned self] note, realm in
           self.updateView()
        }
    }
    
    func updateView() {
        tableView.reloadData()
        hideNewProjectView()
    }
    
    @IBAction func showNewProjectView(_ sender: Any) {
        tableView.tableHeaderView?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.size.width, height: 44))
        tableView.tableHeaderView?.isHidden = false
        tableView.tableHeaderView = tableView.tableHeaderView // tableHeaderView needs to be reassigned to recognize new height
        newProjectTextField.becomeFirstResponder()
    }
    
    func hideNewProjectView() {
        tableView.tableHeaderView?.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.frame.size.width, height: 0))
        tableView.tableHeaderView?.isHidden = true
        tableView.tableHeaderView = tableView.tableHeaderView
        newProjectTextField.endEditing(true)
        newProjectTextField.text = nil
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = newProjectTextField.text else { return }
        store.addProject(name)
    }
    

}

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectCell
        cell.project = projects[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        store.deleteProject(projects[indexPath.row])
    }
    
}

