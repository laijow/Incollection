//
//  ContentCollectionViewCellViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 26.01.2021.
//

import Foundation
import RxSwift

protocol ContentCollectionViewCellViewModelDelegate: class {
    func fetchMediaDidFinish(mediaUrl: String)
}

class ContentCollectionViewCellViewModel {
    
    weak var delegate: ContentCollectionViewCellViewModelDelegate!
    
    private let fetcher: InstagramDataFetcher
    private let mediaData: MediaData
    private let token: InstagramToken?
    private var instagramMedia: InstagramMedia?
    private var disposeBag = DisposeBag()
    
    init(fetcher: InstagramDataFetcher, mediaData: MediaData, token: InstagramToken?) {
        self.fetcher = fetcher
        self.mediaData = mediaData
        self.token = token
    }
    
    func fetchMedia() {
        guard let token = token else { return }
        self.fetcher.fetchInstagramMedia(with: token, mediaId: mediaData.id)
            .take(1)
            .subscribe(onNext: { result in
                switch result {
                case .success(let instagramMedia):
                    self.instagramMedia = instagramMedia
                    self.fetchDidFinish(instagramMedia: instagramMedia)
                    print(instagramMedia.mediaUrl)
                case .failure(let error): print(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchDidFinish(instagramMedia: InstagramMedia) {
        DispatchQueue.main.async {
            let medialUrl = instagramMedia.mediaType == .VIDEO ? instagramMedia.thumbnailUrl : instagramMedia.mediaUrl
            self.delegate.fetchMediaDidFinish(mediaUrl: medialUrl!)
        }
    }
}
