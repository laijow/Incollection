//
//  ContentNavigationController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class ContentNavigationController: UINavigationController {
        
    private let token: InstagramToken?
    private let router: Router
    
    init(token: InstagramToken?, router: Router) {
        self.token = token
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.shadowImage = UIImage()
        self.createControllers()
    }
    
    private func createControllers() {
        let vc = ContentViewController(viewModel: ContentViewControllerViewModel(token: self.token, router: self.router))
        viewControllers = [vc]
    }
    
}
