//
//  InstagramToken.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

typealias InstagramTokenResult = Result<InstagramToken, Error>
typealias InstagramTokenResultOpt = Result<InstagramToken?, Error>

class InstagramToken {
    
    let accessToken: String
    let userId: Int
    
    init(accessToken: String, userId: Int) {
        self.accessToken = accessToken
        self.userId = userId
    }
}
