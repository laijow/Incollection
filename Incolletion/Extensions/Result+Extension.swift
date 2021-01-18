//
//  Result+Extension.swift
//  Incolletion
//
//  Created by Анатолий Ем on 18.01.2021.
//

import Foundation

public extension Result {
    var isFailure: Bool {
        !isSuccess
    }
    
    var isSuccess: Bool {
        switch self {
        case .failure:
            return false
        case .success:
            return true
        }
    }
    
    func getResult() -> Success? {
        switch self {
        case .failure:
            return nil
        case .success(let value):
            return value
        }
    }
    
    func getError() -> Error? {
        switch self {
        case .failure(let error):
            return error
        case .success:
            return nil
        }
    }
}
