//
//  LocalDataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 23.01.2021.
//

import Foundation
import CoreData

protocol LocalDataFetcher {
    func fetchObjects<T: NSManagedObject>(entityType: T.Type, sortDescriptors: [NSSortDescriptor]?) -> [T]?
}
