//
//  InstagramUserDTO.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

typealias InstagramUserDataResult = Result<InstagramUserDTO, Error>


struct InstagramUserDTO: Decodable {
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

class UserMapper: Mapper {
    typealias Input = InstagramUserDTO
    typealias Output = InstagramUser
    
    func map(input: InstagramUserDTO) -> InstagramUser {
        let ids = input.media.data.map { return $0.id }
        return InstagramUser(id: input.id, userName: input.userName, mediaIds: ids)
    }
}
