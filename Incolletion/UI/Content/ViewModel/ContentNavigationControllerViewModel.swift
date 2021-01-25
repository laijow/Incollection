//
//  ContentNavigationControllerViewModel.swift
//  Incolletion
//
//  Created by Анатолий Ем on 23.01.2021.
//

import Foundation
import UIKit

class ContentNavigationControllerViewModel {
    
    private var users: [User]?
    private let user: InstagramUser?
    
    private var fetcher: LocalDataFetcher!
    
    init(user: InstagramUser? = nil) {
        self.user = user
    }
    
    func selectedUserName() -> String? {
        guard let user = self.user else { return nil }
        return user.userName
    }
}
