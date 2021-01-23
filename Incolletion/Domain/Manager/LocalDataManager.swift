//
//  LocalDataManager.swift
//  Incolletion
//
//  Created by Анатолий Ем on 23.01.2021.
//

import Foundation
import CoreData

typealias LocalDataManagerResult = (Error?) -> Void

protocol LocalDataManager {
    func save(result:@escaping LocalDataManagerResult)
    func delete(object: NSManagedObject, result: @escaping LocalDataManagerResult)
}
