//
//  DefaultTokenRepository.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import RxSwift

class DefaultTokenRepository {
    
    private let fetcher: InstagramDataFetcher
    private let tokenMapper: TokenMapper
    private var lastToken: InstagramToken?
    
    init(fetcher: InstagramDataFetcher, tokenMapper: TokenMapper) {
        self.fetcher = fetcher
        self.tokenMapper = tokenMapper
    }
}

extension DefaultTokenRepository: TokenRepository {
    
    func getToken(with code: String) -> Observable<InstagramTokenResult> {
         return self.fetcher.fetchInstagramToken(with: code).map { [weak self] result in
            guard let self = self else { return .failure(ErrorType.InvalidObject) }
            let token = result.map { self.tokenMapper.map(input: $0) }
            self.lastToken = token.getResult()
            return token
        }
    }
    
    func getLastToken() -> InstagramToken? {
        return lastToken
    }
    
    func clear() {
        self.lastToken = nil
    }
}
