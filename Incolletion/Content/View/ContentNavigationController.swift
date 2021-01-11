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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [ContentViewController()]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
