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
    
    init(router: Router = DefaultRouter()) {
        self.router = router
    }
        
    private func presentAuthorization() -> Observable<Void> {
        return Observable<Void>.create {[weak self] observer in
            self?.router.presentAuthorization(authUrl: (self?.buildAuthURL())!, authorizeService: self)
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func buildAuthURL() -> URL {
        var components = URLComponents(string: InstagramApi.getStringURL(.authorize))!
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: InstagramApi.instagramAppID),
            URLQueryItem(name: "redirect_uri", value: InstagramApi.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: InstagramApi.scope)
        ]
        
        return components.url!
    }
    
}

extension AuthorizeService: AuthorizeServiceStarter {
    
    func start() -> Observable<InstagramTokenResult> {
        presentAuthorization().flatMap {[weak self] _ -> Observable<InstagramTokenResult> in
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
