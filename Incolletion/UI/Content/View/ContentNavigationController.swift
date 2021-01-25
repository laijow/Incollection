//
//  ContentNavigationController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class ContentNavigationController: UINavigationController {
    
    private let viewModel: ContentNavigationControllerViewModel
    
    init(viewModel: ContentNavigationControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createControllers()
    }
    
    private func createControllers() {
        let vc = ContentViewController()
        vc.title = self.viewModel.selectedUserName()
        viewControllers = [vc]
    }
    
}
