//
//  UserRepository.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import RxSwift

protocol UserRepository {
    func getUser(accessToken:String, userId: String) -> Observable<InstagramUserResult>
    func getLastUser() -> InstagramUser?
}
