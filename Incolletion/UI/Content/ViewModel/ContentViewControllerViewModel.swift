//
//  ContentViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import RxSwift

protocol ContentViewControllerViewModelViewModel: class {
    func loadingDataDidFinished(title: String)
}

class ContentViewControllerViewModel {
    
    weak var delegate: ContentViewControllerViewModelViewModel!
    
    private let userRepository: UserRepository
    private let tokenRepository: TokenRepository
    private var disposeBag = DisposeBag()
    private var user: InstagramUser?
    
    init(userRepository: UserRepository, tokenRepository: TokenRepository) {
        self.userRepository = userRepository
        self.tokenRepository = tokenRepository
    }
    
    func loadingData() {
        guard let token = tokenRepository.getLastToken() else { return }
        userRepository.getUser(accessToken: token.accessToken, userId: "\(token.userId)")
            .take(1)
            .subscribe(onNext: { result in
                switch result {
                case .success(let user):
                    self.user = user
                    self.loadingFinished(user: user)
                    print(user.userName)
                case .failure(let error): print(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    private func loadingFinished(user: InstagramUser) {
        
        DispatchQueue.main.async {
            self.delegate.loadingDataDidFinished(title: user.userName)
        }
    }
}
