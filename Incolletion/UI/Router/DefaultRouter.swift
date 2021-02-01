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
    
    func presentAuthorization() {
        let vc = InstagramLoginViewController()
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        }
        presentViewController(with: vc)
    }
    
    func changeRootViewController(with viewController: UIViewController) {
        window?.rootViewController? = viewController
    }
    
    func presentViewController(with viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
}
