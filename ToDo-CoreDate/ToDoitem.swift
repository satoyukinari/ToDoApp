//
//  ToDoitem.swift
//  ToDo-CoreDate
//
//  Created by 佐藤志誠 on 2020/01/16.
//  Copyright © 2020 Sato Yukinari. All rights reserved.
//

import Foundation
import CoreData


class ToDoItem: NSManagedObject, Identifiable {
    
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: String?
    
    func fetch() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as!NSFetchRequest<ToDoItem>
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        return request
    }
}
