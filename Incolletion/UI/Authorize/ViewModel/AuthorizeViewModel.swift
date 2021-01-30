//
//  AuthorizeViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import RxSwift

protocol AuthorizeViewControllerViewModelDelegate: NSObject {
    func onAuthorizeResult(error: Error?)
}

class AuthorizeViewModel {
    
    weak var delegate: AuthorizeViewControllerViewModelDelegate?
    
    private(set) var token: InstagramToken?
    
    private let router: Router
    private let authorizeService: AuthorizeService
    private var disposeBag = DisposeBag()
    
    init(router: Router, authorizeService: AuthorizeService) {
        self.router = router
        self.authorizeService = authorizeService
    }
    
    func startOfInstagramAuthorization() {
        authorizeService.start()
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
    
    func declareContent() {
        let vc = ContentNavigationController(navigationBarClass: ContentNavigationBar.self, toolbarClass: nil)
        
        router.changeRootViewController(with: vc)
    }
    
    private func onAuthorizeResult(_ token: InstagramToken?, _ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.token = token
            AppSettings[.accessToken] = token?.accessToken
            AppSettings[.userId] = token?.userId
            AppSettings[.isLoggedIn] = true
            self.delegate?.onAuthorizeResult(error: error)
        }
    }
    
}
