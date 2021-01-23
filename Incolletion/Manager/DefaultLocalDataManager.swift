//
//  DefaultLocalDataManager.swift
//  Incolletion
//
//  Created by Анатолий Ем on 23.01.2021.
//

import Foundation
import CoreData

class DefaultLocalDataManager {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

extension DefaultLocalDataManager: LocalDataManager {
    func save(result: @escaping LocalDataManagerResult) {
        do {
            try self.context.save()
            result(nil)
        } catch let error {
            print("Error save context: \(error.localizedDescription)")
            result(error)
        }
    }
    
    func delete(object: NSManagedObject, result: @escaping LocalDataManagerResult) {
        self.context.delete(object)
        self.save(result: result)
    }
}
