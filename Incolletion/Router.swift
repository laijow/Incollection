//
//  Router.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import UIKit

protocol Router: class {
    func presentAuthorization(authUrl: URL, authorizeService: AuthorizeServiceResolver?)
}

class DefaultRouter: Router {
    
    func presentAuthorization(authUrl: URL, authorizeService: AuthorizeServiceResolver?) {
        guard let authorizeService = authorizeService else { return }
        let vm = InstagramLoginViewControllerViewModel(authorizeService: authorizeService)
        let vc = InstagramLoginViewController(authUrl: authUrl,
                                              viewModel: vm)
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        }
        presentViewController(viewController: vc)
    }
    
    private func presentViewController(viewController: UIViewController) {
        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
}
