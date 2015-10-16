//
//  CDHelper.swift
//  CoreDataStack
//
//  Created by G.D. Sanders on 10/6/15.
//  Copyright © 2015 DigitalEquity, Inc. All rights reserved.
//

import Foundation
import CoreData

class CDHelper  {
    
    // Singleton below
    static let sharedInstance = CDHelper()
    
    lazy var storageDirectory: NSURL = {
        let fm = NSFileManager.defaultManager()
        
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count - 1] as NSURL
        
    }()
    
    lazy var localStoreURL: NSURL = {
        let url = self.storageDirectory.URLByAppendingPathComponent("CoreDataStack.sqlite")
        return url
    
    }()
    
    lazy var modelURL: NSURL = {
        let bundle = NSBundle.mainBundle()
        
        if let url = bundle.URLForResource("Main", withExtension: "momd") {
            return url
        }
        print("CRITICAL - Managed Object Not Found!")
        abort()
    
    }()
    
    lazy var model: NSManagedObjectModel = {
        return NSManagedObjectModel(contentsOfURL: self.modelURL)!
    }()
    
    lazy var coordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.localStoreURL, options: nil)
        }catch  {
            print("Could not add persistent store")
            abort()
        }
        return coordinator
    }()
    
}
