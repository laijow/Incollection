//
//  ContentNavigationControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 23.01.2021.
//

import Foundation

class ContentNavigationControllerViewModel {
    
    private var users: [User]?
    
    private let fetcher: LocalDataFetcher
    
    init(fetcher: LocalDataFetcher) {
        self.fetcher = fetcher
    }
}
