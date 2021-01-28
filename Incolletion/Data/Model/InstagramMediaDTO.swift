//
//  InstagramMediaDTO.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

typealias InstagramMediaResult = Result<InstagramMediaDTO, Error>

struct InstagramMediaDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case mediaUrl = "media_url"
        case thumbnailUrl = "thumbnail_url"
        case userName = "username"
        case timestamp
    }
    var id: String
    var mediaType: MediaType
    var mediaUrl: String
    var thumbnailUrl: String?
    var userName: String
    var timestamp: String
}

enum MediaType: String, Decodable {
    case IMAGE
    case VIDEO
    case CAROUSEL_ALBUM
}

class MediaMapper: Mapper {
    typealias Input = InstagramMediaDTO
    typealias Output = InstagramMedia
    
    func map(input: InstagramMediaDTO) -> Output {
        return InstagramMedia(mediaUrl: input.mediaUrl, thumbnailUrl: input.thumbnailUrl, mediaType: input.mediaType)
    }
}
