//
//  TokenRepository.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import RxSwift

protocol TokenRepository {
    func getShortLiveToken(with code: String) -> Observable<InstagramTokenResult>
    func getLongLiveToken(with accessToken: String) -> Observable<InstagramTokenResult>
    func refreshToken(with accessToken: String) -> Observable<InstagramTokenResult>
    func getLastToken() -> InstagramToken?
    func clear()
}
