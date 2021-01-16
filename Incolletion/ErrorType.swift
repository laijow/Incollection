//
//  ErrorType.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation

enum ErrorType: Error {
    case Cancel
    case InvalidObject
}

extension ErrorType: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .Cancel: return NSLocalizedString("Canceled!", comment: "")
        case .InvalidObject : return NSLocalizedString("Invalid object!", comment: "")
        }
    }
}
