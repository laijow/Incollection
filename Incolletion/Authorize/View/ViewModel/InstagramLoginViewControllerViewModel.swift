//
//  InstagramLoginViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import RxSwift
import RxCocoa

class InstagramLoginViewControllerViewModel: ViewModel {
    
    struct Input {
        let authorized: Signal<String>
        let endFinish: Signal<InstagramTokenResult>
    }
    
    struct Output {
        let beginFinish: Driver<InstagramTokenResult>
        let endFinish: Driver<Bool>
    }
    
    private let authorizeService: AuthorizeServiceResolver
    private let relayBeginFinish = PublishRelay<InstagramTokenResult>()
    
    init(authorizeService: AuthorizeServiceResolver) {
        self.authorizeService = authorizeService
    }
    
    func transform(from input: Input) -> Output {
        let autorized = input.authorized.map { [weak self] result -> InstagramTokenResult in
            guard let _ = self, let range = result.range(of: "?code=") else { return .failure(ErrorType.InvalidObject) }
            let accessToken = String(result[range.upperBound...])
            return .success(accessToken)
        }
        let endFinish = input.endFinish.map { [weak self] result -> Bool in
            guard let self = self else { return false }
            self.resolve(result)
            return true
        }.asDriver(onErrorJustReturn: false)
        
        let beginFinish = Signal.merge(autorized, relayBeginFinish.asSignal())
            .asDriver { Driver.just(.failure($0)) }
        return Output(beginFinish: beginFinish, endFinish: endFinish)
    }
    
    private func resolve(_ result: InstagramTokenResult) {
        authorizeService.resolve(result: result)
    }
}
