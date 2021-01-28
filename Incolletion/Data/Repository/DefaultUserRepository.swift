//
//  DefaultUserRepository.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import RxSwift

class DefaultUserRepository {
    
    private let fetcher: InstagramDataFetcher
    private var lastUser: InstagramUser?
    private let userMapper: UserMapper
    
    init(fetcher: InstagramDataFetcher, userMapper: UserMapper) {
        self.fetcher = fetcher
        self.userMapper = userMapper
    }
}

extension DefaultUserRepository: UserRepository {
    func getUser(accessToken: String, userId: String) -> Observable<InstagramUserResult> {
        return fetcher.fetchInstagramUser(accessToken: accessToken, userId: userId).map { [weak self] result in
            guard let self = self else { return .failure(ErrorType.InvalidObject) }
            let user = result.map { self.userMapper.map(input: $0) }
            
            self.lastUser = user.getResult()
            return user
        }
    }
    
    func getLastUser() -> InstagramUser? {
        return lastUser
    }
}
