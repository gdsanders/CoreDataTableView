//
//  ViewController.swift
//  CoreDataTableView
//
//  Created by G.D. Sanders on 10/16/15.
//  Copyright © 2015 DigitalEquity, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var names = [String]()
    let tableView = UITableView()
    var newNameInput: UITextField?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        
        title = "Users"
        edgesForExtendedLayout = UIRectEdge.None
        tableView.frame = view.frame
        
        view.addSubview(tableView)
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
    }


}

