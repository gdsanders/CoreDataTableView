//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by G.D. Sanders on 10/16/15.
//  Copyright © 2015 DigitalEquity, Inc. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var names = [String]()
    let tableView = UITableView()
    var newNameInput: UITextField?
    
    var context: NSManagedObjectContext?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        
        title = "Users"
        edgesForExtendedLayout = UIRectEdge.None
        tableView.frame = view.frame
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: Selector ("toggleEdit"))
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        navigationItem.rightBarButtonItem = addButton
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleEdit() {
        tableView.setEditing(!tableView.editing, animated: true)
        let title = tableView.editing ? "Done" : "Edit"
        navigationItem.leftBarButtonItem?.title = title
    }
    
    func insertNewObject(sender: AnyObject) {
        let newNameAlert = UIAlertController(title: "Add New User", message: "What's the user's name?", preferredStyle: UIAlertControllerStyle.Alert)
        newNameAlert.addTextFieldWithConfigurationHandler { (alertTextField) -> Void in
            self.newNameInput = alertTextField
        }
        newNameAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        newNameAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: addNewUser))
        presentViewController(newNameAlert, animated: true, completion: nil)
    }
    
    func addNewUser(alert: UIAlertAction!) {
        guard let name = newNameInput?.text else {return}
        names.append(name)
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            names.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}






