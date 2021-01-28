//
//  TokenRepository.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import RxSwift

protocol TokenRepository {
    func getToken(with code: String) -> Observable<InstagramTokenResult>
    func getLastToken() -> InstagramToken?
    func clear()
}
