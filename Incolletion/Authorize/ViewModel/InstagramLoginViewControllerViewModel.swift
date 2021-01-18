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

class InstagramLoginViewControllerViewModel {
    
    private let authorizeService: AuthorizeServiceResolver
    private let fetcher: InstagramDataFetcher
    
    private let relayBeginFinish = PublishRelay<InstagramTokenResult>()
    
    init(authorizeService: AuthorizeServiceResolver, fetcher: InstagramDataFetcher = DataFetcherService()) {
        self.authorizeService = authorizeService
        self.fetcher = fetcher
    }
    
    func authorizeFinished(stringURL: String) -> Bool {
        return stringURL.contains("?code=")
    }
    
    private func resolve(_ result: InstagramTokenResult) {
        authorizeService.resolve(result: result)
    }
}

extension InstagramLoginViewControllerViewModel: ViewModel {
    
    struct Input {
        let getToken: Signal<String>
        let endFinish: Signal<InstagramTokenResult>
    }
    
    struct Output {
        let beginFinish: Driver<InstagramTokenResult>
        let endFinish: Driver<Bool>
    }
    
    func transform(from input: Input) -> Output {
        let getToken = input.getToken.flatMap { [weak self] result -> Signal<InstagramTokenResult> in
            let defaultError = InstagramTokenResult.failure(ErrorType.InvalidObject)
            guard let _ = self, let range = result.range(of: "?code=") else { return Signal.just(defaultError) }
            
            let code = String(result[range.upperBound...])
            
            guard let self = self else { return Signal.just(defaultError) }
            return self.fetcher.fetchInstagramToken(with: code).asSignal(onErrorJustReturn: defaultError)
        }
        let endFinish = input.endFinish.map { [weak self] result -> Bool in
            guard let self = self else { return false }
            self.resolve(result)
            return true
        }.asDriver(onErrorJustReturn: false)
        
        let beginFinish = Signal.merge(getToken, relayBeginFinish.asSignal())
            .asDriver { Driver.just(.failure($0)) }
        return Output(beginFinish: beginFinish, endFinish: endFinish)
    }
}
