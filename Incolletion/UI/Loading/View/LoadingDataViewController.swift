//
//  LoadingDataViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 20.01.2021.
//

import UIKit

class LoadingDataViewController: UIViewController {

    private let viewModel: LoadingDataViewModel
    private var imageView: UIImageView!
    private var preloaderView = UIActivityIndicatorView(style: .gray)
    
    init(viewModel: LoadingDataViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupPreloaderView()
        setupImageView()
        setupLabel()
        
        viewModel.loadingData()
    }
    
}

// Setup preloader view
extension LoadingDataViewController {
    
    private func setupPreloaderView() {
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 100),
            container.widthAnchor.constraint(equalToConstant: 100),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        preloaderView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(preloaderView)
        
        NSLayoutConstraint.activate([
            preloaderView.topAnchor.constraint(equalTo: container.topAnchor),
            preloaderView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            preloaderView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            preloaderView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        preloaderView.startAnimating()
    }
}

// Setup image view
extension LoadingDataViewController {
    
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
extension LoadingDataViewController {
    
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
