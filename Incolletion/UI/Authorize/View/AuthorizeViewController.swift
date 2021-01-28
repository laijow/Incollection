//
//  AuthorizeViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import UIKit

class AuthorizeViewController: UIViewController {
    
    private lazy var viewModel = makeViewModel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
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
        button.addTarget(self, action: #selector(instagramAuthorization), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func instagramAuthorization() {
        viewModel.delegate = self
        viewModel.startOfInstagramAuthorization()
    }
    
}

extension AuthorizeViewController: AuthorizeViewControllerViewModelDelegate {
    
    func onAuthorizeResult(error: Error?) {
        self.presentedViewController?.dismiss(animated: true, completion: {
            guard let error = error else {
                self.viewModel.declareLoadingViewController()
                return
            }
            
            self.showErrorAlert(error)
        })
    }
}

// Error Alert
extension AuthorizeViewController {
    
    func showErrorAlert(_ error: Error) {
        let alert = UIAlertController.init(title: "Ошибка авторизации.", message: "При попытке авторизации, произошла ошибка.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Понятно", style: .default) { (action) in
            self.viewModel.declareLoadingViewController()
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
