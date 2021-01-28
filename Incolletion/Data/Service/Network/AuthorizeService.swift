//
//  AuthService.swift
//  Incolletion
//
//  Created by Анатолий Ем on 15.01.2021.
//

import Foundation
import UIKit
import RxSwift

class AuthorizeService {
    
    private let router: Router
    private let resolved = PublishSubject<InstagramTokenResult>()
    
    init(router: Router) {
        self.router = router
    }
        
    private func presentAuthorization() -> Observable<Void> {
        return Observable<Void>.create {[weak self] observer in
            self?.router.presentAuthorization()
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

extension AuthorizeService: AuthorizeServiceStarter {
    
    func start() -> Observable<InstagramTokenResult> {
        return presentAuthorization().flatMap {[weak self] _ -> Observable<InstagramTokenResult> in
            guard let self = self else { return Observable.just(.failure(ErrorType.InvalidObject)) }
            return self.resolved.asObserver().share()
        }
    }
}

extension AuthorizeService: AuthorizeServiceResolver {
    
    func resolve(result: InstagramTokenResult) {
        resolved.onNext(result)
    }
}
