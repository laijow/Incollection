//
//  LoadingDataViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 20.01.2021.
//

import Foundation
import RxSwift

protocol LoadingDataViewModelDelegate: class {
    func loadingDataDidFinished()
}

class LoadingDataViewModel {
    
    weak var delegate: LoadingDataViewModelDelegate!
    
    private let token: InstagramToken?
    private let router: Router
    private let fetcher: InstagramDataFetcher
    private var disposeBag = DisposeBag()
    
    init(token: InstagramToken?, router: Router, fetcher: InstagramDataFetcher = DataFetcherService()) {
        self.token = token
        self.router = router
        self.fetcher = fetcher
    }
    
    func loadingData() {
        guard let token = self.token else { return }
        fetcher.fetchInstagramUser(with: token)
            .take(1)
            .subscribe(onNext: { result in
                switch result {
                case .success(let user):
                    self.loadingFinished(user: user)
                    print(user.userName)
                case .failure(let error): print(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    private func loadingFinished(user: InstagramUser) {
        DispatchQueue.main.async {
            self.delegate.loadingDataDidFinished()
            self.goToUserContent(user: user)
        }
    }
    
    private func goToUserContent(user: InstagramUser) {
        let vm = ContentNavigationControllerViewModel(user: user)
        let vc = ContentNavigationController(viewModel:vm)
        self.router.changeRootViewController(with: vc)
    }
}
