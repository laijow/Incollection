//
//  ContentCollectionViewCellViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 26.01.2021.
//

import Foundation

class ContentCollectionViewCellViewModel {
    
    private let fetcher: InstagramDataFetcher
    private let media: MediaData
    
    init(fetcher: InstagramDataFetcher, media: MediaData) {
        self.fetcher = fetcher
        self.media = media
    }
    
    func fetchMedia() {
        
    }
}
