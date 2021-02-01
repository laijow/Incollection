//
//  UIContainer.swift
//  Incolletion
//
//  Created by Анатолий Ем on 28.01.2021.
//

import Foundation
import Resolver

extension ContentCollectionView: Resolving {
    func makeViewModel() -> ContentCollectionViewViewModel { resolver.resolve() } 
}

extension ContentCollectionViewCell: Resolving {
    func makeViewModel() -> ContentCollectionViewCellViewModel { resolver.resolve() }
}

extension ContentViewController: Resolving {
    func makeViewModel() -> ContentViewControllerViewModel { return resolver.resolve() }
    func makePickerManager() -> ImagePickerManager { return resolver.resolve() }
}

extension AuthorizeViewController: Resolving {
    func makeViewModel() -> AuthorizeViewModel { return resolver.resolve() }
}

extension InstagramLoginViewController: Resolving {
    func makeViewModel() -> InstagramLoginViewModel { return resolver.resolve() } 
}

extension ContentImagePickerView: Resolving {
    func makeViewModel() -> ContentImagePickerViewViewModel { return resolver.resolve() }
}

extension ContentImagePickerCollectionView: Resolving {
    func makeViewModel() -> ContentImagePickerCollectionViewViewModel { return resolver.resolve() }
}

extension Resolver {
    public static func registerUI() {
        register { DefaultRouter() }
            .implements(Router.self)
        register { InstagramLoginViewModel(authorizeService: resolve(), tokenRepository: resolve()) }
        register { AuthorizeViewModel(router: resolve(), authorizeService: resolve()) }
        register { ContentViewControllerViewModel(userRepository: resolve(), tokenRepository: resolve()) }
        register { ContentCollectionViewViewModel(userRepository: resolve(), tokenRepository: resolve()) }
        register { ContentCollectionViewCellViewModel(fetcher: resolve(), mediaMapper: resolve()) }
        register { ContentImagePickerView() }
        register { ContentImagePickerCollectionViewViewModel(router: resolve()) }
    }
}
