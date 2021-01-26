//
//  ContentViewControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import RxSwift

protocol ContentViewControllerViewModelViewModel: class {
    func loadingDataDidFinished(title: String?)
}

class ContentViewControllerViewModel {
    
    weak var delegate: ContentViewControllerViewModelViewModel!
    
    private let token: InstagramToken?
    private let router: Router
    private let fetcher: InstagramDataFetcher
    private var disposeBag = DisposeBag()
    private var user: InstagramUser?
    
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
                    self.user = user
                    self.loadingFinished(user: user)
                    print(user.userName)
                case .failure(let error): print(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func getCollectionViewViewModel() -> ContentCollectionViewViewModel {
        return ContentCollectionViewViewModel(medias: user?.media.data, fetcher: fetcher, token: token)
    }
    
    private func loadingFinished(user: InstagramUser) {
        DispatchQueue.main.async {
            self.delegate.loadingDataDidFinished(title: user.userName)
        }
    }
}
