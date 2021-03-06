//
//  ContentCollectionViewCellViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 26.01.2021.
//

import Foundation
import UIKit
import RxSwift

protocol ContentCollectionViewCellViewModelDelegate: class {
    func fetchMediaDidFinish(mediaUrl: String, typeImage: UIImage)
}

class ContentCollectionViewCellViewModel {
    
    weak var delegate: ContentCollectionViewCellViewModelDelegate!
    
    private let fetcher: InstagramDataFetcher
    private let mediaMapper: MediaMapper
    private var instagramMedia: InstagramMedia?
    private var disposeBag = DisposeBag()
        
    init(fetcher: InstagramDataFetcher, mediaMapper: MediaMapper) {
        self.fetcher = fetcher
        self.mediaMapper = mediaMapper
    }
    
    func fetchMedia(accessToken: String, mediaId: String) {
        self.fetcher.fetchInstagramMedia(accessToken: accessToken, mediaId: mediaId)
            .take(1)
            .subscribe(onNext: { result in
                switch result {
                case .success(let result):
                    let instagramMedia = self.mediaMapper.map(input: result)
                    self.instagramMedia = instagramMedia
                    self.fetchDidFinish(instagramMedia: instagramMedia)
                    print(instagramMedia.mediaUrl)
                case .failure(let error): print(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    private func createTypeImage(with mediaType: MediaType) -> UIImage {
        let image: UIImage
        switch mediaType {
        case .IMAGE: image = UIImage()
        case .VIDEO: image = UIImage(named: "play")!
        case .CAROUSEL_ALBUM: image = UIImage(named: "manyPhoto")!
        }
        return image
    }
    
    private func fetchDidFinish(instagramMedia: InstagramMedia) {
        DispatchQueue.main.async {
            let mediaUrl = instagramMedia.mediaType == .VIDEO ? instagramMedia.thumbnailUrl : instagramMedia.mediaUrl
            self.delegate.fetchMediaDidFinish(mediaUrl: mediaUrl!, typeImage: self.createTypeImage(with: instagramMedia.mediaType))
        }
    }
}
