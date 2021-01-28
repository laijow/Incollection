//
//  InstagramDataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 18.01.2021.
//

import Foundation
import RxSwift

protocol InstagramDataFetcher {    
    func fetchInstagramToken(with code: String) -> Observable<AuthorizeResult>
    func fetchInstagramUser(accessToken: String, userId: String) -> Observable<InstagramUserDataResult>
    func fetchInstagramMedia(accessToken: String, mediaId: String) -> Observable<InstagramMediaResult>
}
