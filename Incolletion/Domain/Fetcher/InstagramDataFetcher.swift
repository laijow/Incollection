//
//  InstagramDataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 18.01.2021.
//

import Foundation
import RxSwift

protocol InstagramDataFetcher {    
    func fetchInstagramShortLifeToken(with code: String) -> Observable<InstagramTokenDTOResult>
    func fetchInstagramLongLifeToken(accessToken: String) -> Observable<InstagramTokenDTOResult>
    func fetchInstagramRefreshToken(accessToken: String) -> Observable<InstagramTokenDTOResult>
    func fetchInstagramUser(accessToken: String, userId: String) -> Observable<InstagramUserDataResult>
    func fetchInstagramMedia(accessToken: String, mediaId: String) -> Observable<InstagramMediaResult>
}
