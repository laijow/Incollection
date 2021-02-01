//
//  InstagramTokenDTO.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation

typealias InstagramTokenDTOResult = Result<InstagramTokenDTO, Error>

struct InstagramTokenDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case userId = "user_id"
        case expiresIn = "expires_in"
    }
    var accessToken: String
    var userId: Int?
    var expiresIn: Int?
}

class TokenMapper: Mapper {
    typealias Input = InstagramTokenDTO
    typealias Output = InstagramToken
    
    func map(input: InstagramTokenDTO) -> InstagramToken {
        return InstagramToken(accessToken: input.accessToken, userId: input.userId ?? 0, expiresIn: input.expiresIn ?? 0)
    }
}
