//
//  ToDoItem.swift
//  SwiftUI-ToDoList
//
//  Created by Artem Klimov on 20/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject, Identifiable {
    @NSManaged public var createdAt: Date?
    @NSManaged public var title: String?
    
}


extension ToDoItem {
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
        let request = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
