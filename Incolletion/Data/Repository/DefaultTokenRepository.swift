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
    
    private func updateToken(with result: InstagramTokenDTOResult) -> InstagramTokenResult {
        let tokenResult = result.map { self.tokenMapper.map(input:$0) }
        let newToken = tokenResult.getResult()
        
        guard let lastToken = self.lastToken else {
            self.lastToken = newToken
            return tokenResult
        }
        
        guard let token = newToken else { return .failure(ErrorType.InvalidObject) }
        
        lastToken.accessToken = token.accessToken
        if token.expiresIn != 0 {
            lastToken.expiresIn = token.expiresIn
        }
        
        return .success(lastToken)
    }
}

extension DefaultTokenRepository: TokenRepository {
        
    func getShortLiveToken(with code: String) -> Observable<InstagramTokenResult> {
         return self.fetcher.fetchInstagramShortLifeToken(with: code).map { [weak self] result in
            guard let self = self else { return .failure(ErrorType.InvalidObject) }
            return self.updateToken(with: result)
        }
    }
    
    func getLongLiveToken(with accessToken: String) -> Observable<InstagramTokenResult> {
        return self.fetcher.fetchInstagramLongLifeToken(accessToken: accessToken).map { [weak self] result in
            guard let self = self else { return .failure(ErrorType.InvalidObject) }
            return self.updateToken(with: result)
        }
    }
    
    func refreshToken(with accessToken: String) -> Observable<InstagramTokenResult> {
        return self.fetcher.fetchInstagramRefreshToken(accessToken: accessToken).map { [weak self] result in
            guard let self = self else { return .failure(ErrorType.InvalidObject) }
            return self.updateToken(with: result)
        }
    }
    
    func getLastToken() -> InstagramToken? {
        let token: InstagramToken?
        if let lastToken = lastToken {
            token = lastToken
        } else if AppSettings.boolValue(.isLoggedIn) {
            token = InstagramToken(accessToken: AppSettings.stringValue(.accessToken)!, userId: AppSettings.intValue(.userId)!, expiresIn: AppSettings.intValue(.expiresIn)!)
        } else {
            token = nil
        }
        return token
    }
    
    func clear() {
        self.lastToken = nil
    }
}
