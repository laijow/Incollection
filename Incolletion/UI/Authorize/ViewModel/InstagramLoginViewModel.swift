//
//  InstagramLoginViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import WebKit
import RxSwift
import RxCocoa

class InstagramLoginViewModel {
    
    private let authorizeService: AuthorizeServiceResolver
    private let tokenRepository: TokenRepository
    
    private let relayShortLiveTokenFinish = PublishRelay<InstagramTokenResult>()
    private let relayBeginFinish = PublishRelay<InstagramTokenResult>()
    
    init(authorizeService: AuthorizeServiceResolver, tokenRepository: TokenRepository) {
        self.authorizeService = authorizeService
        self.tokenRepository = tokenRepository
    }
    
    func authorizeFinished(stringURL: String) -> Bool {
        return stringURL.contains("?code=")
    }
    
    private func resolve(_ result: InstagramTokenResult) {
        authorizeService.resolve(result: result)
    }
    
    func buildAuthURL() -> URL {
        var components = URLComponents(string: InstagramApi.getAuthStringURL(.authorize))!
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: InstagramApi.instagramAppID),
            URLQueryItem(name: "redirect_uri", value: InstagramApi.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: InstagramApi.scope)
        ]
        
        return components.url!
    }
}

extension InstagramLoginViewModel: ViewModel {
    
    struct Input {
        let getShortLiveToken: Signal<String>
        let getLongLiveToken: Signal<InstagramTokenResult>
        let endFinish: Signal<InstagramTokenResult>
    }
    
    struct Output {
        let shortLiveToken: Driver<InstagramTokenResult>
        let beginFinish: Driver<InstagramTokenResult>
        let endFinish: Driver<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let getShortLiveToken = input.getShortLiveToken.flatMap { [weak self] result -> Signal<InstagramTokenResult> in
            let defaultError = InstagramTokenResult.failure(ErrorType.InvalidObject)
            guard let _ = self, let range = result.range(of: "?code=") else { return Signal.just(defaultError) }
            
            let code = String(result[range.upperBound...])
            
            guard let self = self else { return Signal.just(defaultError) }
            return self.tokenRepository.getShortLiveToken(with: code).asSignal(onErrorJustReturn: defaultError)
        }
        let getLongLiveToken = input.getLongLiveToken.flatMap { [weak self] result -> Signal<InstagramTokenResult> in
            let defaultError = InstagramTokenResult.failure(ErrorType.InvalidObject)
            guard let self = self, let token = result.getResult() else { return Signal.just(defaultError) }
            return self.tokenRepository.getLongLiveToken(with: token.accessToken).asSignal(onErrorJustReturn: defaultError)
        }
        let endFinish = input.endFinish.map { [weak self] result -> Bool in
            guard let self = self else { return false }
            self.resolve(result)
            return true
        }.asDriver(onErrorJustReturn: false)
        
        let shortLiveTokenFinish = Signal.merge(getShortLiveToken, relayShortLiveTokenFinish.asSignal())
            .asDriver { Driver.just(.failure($0)) }
        
        let beginFinish = Signal.merge(getLongLiveToken, relayBeginFinish.asSignal())
            .asDriver { Driver.just(.failure($0)) }
        return Output(shortLiveToken: shortLiveTokenFinish, beginFinish: beginFinish, endFinish: endFinish)
    }
}
