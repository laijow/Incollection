//
//  Router.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import Foundation
import UIKit

protocol Router: class {
    func presentAuthorization()
    func changeRootViewController(with viewController: UIViewController)
}


