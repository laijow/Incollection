//
//  ContentCollectionViewViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 26.01.2021.
//

import Foundation

class ContentCollectionViewViewModel {
    
    private let medias: [MediaData]?
    private let fetcher: InstagramDataFetcher
    private let token: InstagramToken?
    
    init(medias: [MediaData]? = nil, fetcher: InstagramDataFetcher, token: InstagramToken?) {
        self.medias = medias
        self.fetcher = fetcher
        self.token = token
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let medias = medias else { return 0 }
        return medias.count
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> ContentCollectionViewCellViewModel {
        let media = medias![indexPath.row]
        return ContentCollectionViewCellViewModel(fetcher: fetcher, mediaData: media, token: token)
    }
}
