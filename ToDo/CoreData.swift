//
//  CoreData.swift
//  ToDo
//
//  Created by Mohamed Mahmoud Zaki on 7/12/18.
//  Copyright © 2018 Mohamed Mahmoud Zaki. All rights reserved.
//

import Foundation
import CoreData
class CoredataStack {
    var containter : NSPersistentContainer {
        let contrainer = NSPersistentContainer(name: "Todos")
        contrainer.loadPersistentStores { (description, error) in
            guard error == nil else {return}
            
        }
        return contrainer
    }
    var managed :NSManagedObjectContext {
        return containter.viewContext
    }
}
