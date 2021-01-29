//
//  AuthorizeViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 16.01.2021.
//

import UIKit

class AuthorizeViewController: UIViewController {
    
    private lazy var viewModel = makeViewModel()
    private var imageView: UIImageView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupInstaButton()
        setupImageView()
        setupLabel()
        setupSkipButton()
    }
        
    @objc func instagramAuthorization() {
        viewModel.delegate = self
        viewModel.startOfInstagramAuthorization()
    }
    
}

// Setup skip button
extension AuthorizeViewController {
    
    private func setupSkipButton() {
        let skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        skipButton.setTitle("Пропустить", for: .normal)
        skipButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        skipButton.setTitleColor(.black, for: .normal)
        
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func skipTapped() {
        self.viewModel.declareContent()
    }
}

// Setup intagram button
extension AuthorizeViewController {
    
    private func setupInstaButton() {
        let width = view.bounds.width - 60
        let button = InstagramButton(frame: CGRect(x: view.center.x - width/2, y: view.bounds.maxY - 100, width: width, height: 50))
        button.setTitle("Sign in with Instagram", for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(instagramAuthorization), for: .touchUpInside)
        view.addSubview(button)
    }
}
 
// Setup image view
extension AuthorizeViewController {
    
    private func setupImageView() {
        let image = UIImage(named: "Example")
        imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
}

// Setup label
extension AuthorizeViewController {
    
    private func setupLabel() {
        let label = UILabel()
        label.font = UIFont(name: "Noteworthy-Bold", size: 25)
        label.text = "Создай свою идеальную страничку!"
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            label.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension AuthorizeViewController: AuthorizeViewControllerViewModelDelegate {
    
    func onAuthorizeResult(error: Error?) {
        self.presentedViewController?.dismiss(animated: true, completion: {
            guard let error = error else {
                self.viewModel.declareContent()
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
            self.viewModel.declareContent()
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}
