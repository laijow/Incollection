//
//  InstagramMedia.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

class InstagramMedia {
    
    let mediaUrl: String
    let thumbnailUrl: String?
    let mediaType: MediaType
    
    init(mediaUrl: String, thumbnailUrl: String?, mediaType: MediaType) {
        self.mediaUrl = mediaUrl
        self.thumbnailUrl = thumbnailUrl
        self.mediaType = mediaType
    }
}
