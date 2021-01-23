//
//  DefaultLocalDataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 23.01.2021.
//

import Foundation
import CoreData

class DefaultLocalDataFetcher: LocalDataFetcher {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchObjects<T>(entityType: T.Type, sortDescriptors: [NSSortDescriptor]?) -> [T]? where T : NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        do {
            return try context.fetch(request)
        }
        catch let error as NSError {
            print("Error fetch local objects: \(error.localizedDescription)")
            return nil
        }
    }
}
