//
//  TokenRepository.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation

protocol TokenRepository {
    func getAccessToken()
    func clear()
}
