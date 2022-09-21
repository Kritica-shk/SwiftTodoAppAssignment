//
//  TodoItemList+CoreDataProperties.swift
//  TodoApp
//
//  Created by EKbana on 21/09/2022.
//
//

import Foundation
import CoreData


extension TodoItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItemList> {
        return NSFetchRequest<TodoItemList>(entityName: "TodoItemList")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?

}

extension TodoItemList : Identifiable {

}
