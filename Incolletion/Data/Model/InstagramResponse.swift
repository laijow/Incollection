//
//  InstagramResponse.swift
//  Incolletion
//
//  Created by Анатолий Ем on 15.01.2021.
//

import Foundation

typealias InstagramTokenResult = Result<InstagramToken, Error>
typealias InstagramUserResult = Result<InstagramUser, Error>

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
    }
  var id: String
  var userName: String
}

struct Feed: Decodable {
  var data: [MediaData]
  var paging: PagingData
}

struct MediaData: Decodable {
  var id: String
  var caption: String?
}

struct PagingData: Decodable {
  var cursors: CursorData
  var next: String
}

struct CursorData: Decodable {
  var before: String
  var after: String
}

struct InstagramMedia: Decodable {
  var id: String
  var mediaType: MediaType
  var mediaUrl: String
  var username: String
  var timestamp: String
}

enum MediaType: String, Decodable {
  case IMAGE
  case VIDEO
  case CAROUSEL_ALBUM
}
