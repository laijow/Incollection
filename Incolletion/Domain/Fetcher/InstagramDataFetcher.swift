//
//  InstagramDataFetcher.swift
//  Incolletion
//
//  Created by Анатолий Ем on 18.01.2021.
//

import Foundation
import RxSwift

protocol InstagramDataFetcher {
    func fetchInstagramToken(with code: String) -> Observable<InstagramTokenResult>
    func fetchInstagramUser(with token: InstagramToken) -> Observable<InstagramUserResult>
}
