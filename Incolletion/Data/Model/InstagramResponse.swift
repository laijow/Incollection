//
//  InstagramResponse.swift
//  Incolletion
//
//  Created by Анатолий Ем on 15.01.2021.
//

import Foundation

typealias InstagramTokenResult = Result<InstagramToken, Error>
typealias InstagramUserResult = Result<InstagramUser, Error>
typealias InstagramMediaResult = Result<InstagramMedia, Error>

struct InstagramToken: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case userId = "user_id"
    }
    var accessToken: String
    var userId: Int
}

struct InstagramUser: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case media
    }
    var id: String
    var userName: String
    var media: Feed
}

struct Feed: Decodable {
    var data: [MediaData]
    var paging: PagingData
}

struct MediaData: Decodable {
    var id: String
}

struct PagingData: Decodable {
    var cursors: CursorData
}

struct CursorData: Decodable {
    var before: String
    var after: String
}

struct InstagramMedia: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case mediaUrl = "media_url"
        case userName = "username"
        case timestamp
    }
    var id: String
    var mediaType: MediaType
    var mediaUrl: String
    var userName: String
    var timestamp: String
}

enum MediaType: String, Decodable {
    case IMAGE
    case VIDEO
    case CAROUSEL_ALBUM
}
