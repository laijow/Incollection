//
//  Mapper.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output
    
    func map(input: Input) -> Output
}
