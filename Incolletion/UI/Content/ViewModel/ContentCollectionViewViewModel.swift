//
//  ContentCollectionViewViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 26.01.2021.
//

import Foundation

class ContentCollectionViewViewModel {
    
    private let userRepository: UserRepository
    private let tokenRepository: TokenRepository
    private var mediaIds: [String]?
    
    init(userRepository: UserRepository, tokenRepository: TokenRepository) {
        self.userRepository = userRepository
        self.tokenRepository = tokenRepository
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let user = userRepository.getLastUser() else { return 0 }
        mediaIds = user.mediaIds
        return user.mediaIds.count
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> String {
        let mediaId = mediaIds![indexPath.row]
        return mediaId
    }
    
    func getAccessToken() -> String? {
        return tokenRepository.getLastToken()?.accessToken
    }
}
