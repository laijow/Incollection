//
//  AuthorizeViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import UIKit

class AuthorizeViewController: UIViewController {
    
    private let viewModel: AuthorizeViewControllerViewModel
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: AuthorizeViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainWhite()
        
        setupInstaButton()
    }
    
    func setupInstaButton() {
        let button = UIButton(frame: CGRect(x: view.center.x - 100, y: view.center.y, width: 200, height: 50))
        button.setTitle("Sign in with Instagram", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showInstagramLoginViewController), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func showInstagramLoginViewController() {
        viewModel.showInstagramLoginViewController()
    }
    
}

extension AuthorizeViewController: AuthorizeViewControllerViewModelDelegate {
    func onAuthorizeResult(error: Error?) {
        print(error?.localizedDescription)
    }
}
