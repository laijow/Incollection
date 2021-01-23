//
//  DefaultRouter.swift
//  Incolletion
//
//  Created by Анатолий Ем on 17.01.2021.
//

import Foundation
import UIKit

class DefaultRouter: Router {
    
    private let window: UIWindow? = UIApplication.shared.windows.first
    
    func presentAuthorization(authUrl: URL, authorizeService: AuthorizeServiceResolver?) {
        guard let authorizeService = authorizeService else { return }
        let vm = InstagramLoginViewModel(authorizeService: authorizeService)
        let vc = InstagramLoginViewController(authUrl: authUrl,
                                              viewModel: vm)
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        }
        presentViewController(viewController: vc)
    }
    
    func changeRootViewController(with viewController: UIViewController) {
        window?.rootViewController? = viewController
    }
    
    private func presentViewController(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
