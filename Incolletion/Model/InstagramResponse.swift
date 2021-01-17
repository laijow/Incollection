//
//  InstagramResponse.swift
//  Incolletion
//
//  Created by Анатолий Ем on 15.01.2021.
//

import Foundation

typealias InstagramTokenResult = Result<String, Error>

struct InstagramTestUser: Codable {
  var accessToken: String
  var userId: Int
}

struct InstagramUser: Codable {
  var id: String
  var username: String
}

struct Feed: Codable {
  var data: [MediaData]
  var paging: PagingData
}

struct MediaData: Codable {
  var id: String
  var caption: String?
}

struct PagingData: Codable {
  var cursors: CursorData
  var next: String
}

struct CursorData: Codable {
  var before: String
  var after: String
}

struct InstagramMedia: Codable {
  var id: String
  var mediaType: MediaType
  var mediaUrl: String
  var username: String
  var timestamp: String
}

enum MediaType: String, Codable {
  case IMAGE
  case VIDEO
  case CAROUSEL_ALBUM
}
