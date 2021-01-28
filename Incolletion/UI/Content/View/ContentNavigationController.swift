//
//  ContentNavigationController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class ContentNavigationController: UINavigationController {
            
    init() {
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
        let vc = ContentViewController()
        viewControllers = [vc]
    }
    
}
