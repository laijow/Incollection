//
//  DefaultRouter.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import UIKit

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
