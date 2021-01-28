//
//  InstagramUser.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

typealias InstagramUserResult = Result<InstagramUser, Error>

class InstagramUser {
    
    let id: String
    let userName: String
    let mediaIds: [String]
    
    init(id: String, userName: String, mediaIds: [String]) {
        self.id = id
        self.userName = userName
        self.mediaIds = mediaIds
    }
}
