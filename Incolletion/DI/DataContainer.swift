//
//  DataContainer.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerData() {
        register() { DataFetcherService(networkDataFetcher: resolve()) }
            .implements(InstagramDataFetcher.self)
            .scope(ResolverScope.application)
        register() { TokenMapper() }
            .scope(ResolverScope.application)
        register() { UserMapper() }
            .scope(ResolverScope.application)
        register() { MediaMapper() }
            .scope(ResolverScope.application)
        register() { DefaultTokenRepository(fetcher: resolve(), tokenMapper: resolve()) }
            .implements(TokenRepository.self)
            .scope(ResolverScope.application)
        register() { DefaultUserRepository(fetcher: resolve(), userMapper: resolve()) }
            .implements(UserRepository.self)
            .scope(ResolverScope.application)
        register() { NetworkDataFetcher(networking: resolve()) }
            .implements(DataFetcher.self)
            .scope(ResolverScope.application)
    }
}
