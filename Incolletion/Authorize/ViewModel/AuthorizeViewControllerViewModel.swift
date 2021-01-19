//
//  AuthorizeViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import RxSwift

protocol AuthorizeViewControllerViewModelDelegate: NSObject {
    func onAuthorizeResult(token: InstagramToken?, error: Error?)
}

class AuthorizeViewControllerViewModel {
    
    let authorizeService: AuthorizeServiceStarter
    
    weak var delegate: AuthorizeViewControllerViewModelDelegate?
    
    private var disposeBag = DisposeBag()
    
    init(authorizeService: AuthorizeServiceStarter) {
        self.authorizeService = authorizeService
    }
    
    func showInstagramLoginViewController() {
        self.authorizeService.start()
            .take(1)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let token) :
                    self?.onAuthorizeResult(token, nil)
                case .failure(let error) :
                    self?.onAuthorizeResult(nil, error)
                }
            }).disposed(by: disposeBag)
    }
    
    private func onAuthorizeResult(_ token: InstagramToken?, _ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            AppSettings[.accessToken] = token?.accessToken
            AppSettings[.userId] = token?.userId
            AppSettings[.isLoggedIn] = true
            self?.delegate?.onAuthorizeResult(token: token, error: error)
        }
    }
    
}
