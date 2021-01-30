//
//  ContentViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 10.01.2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    private var collectionView: ContentCollectionView!
    private lazy var viewModel = makeViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadingData()
        setupCollectionView()
        setupNavigationItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentViewController {
    
    private func setupCollectionView() {
        collectionView = ContentCollectionView(frame: view.bounds)
        view.addSubview(collectionView)
    }
}

// Setup navigation item
extension ContentViewController {
    
    private func setupNavigationItem() {
        setupTitleView()
        setupLeftButton(title: nil)
        setupRightButton()
    }
    
    private func setupTitleView() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 44))
        let titleImageView = UIImageView(image: UIImage(named: "preview")!)
        
        titleImageView.frame = containerView.bounds
        titleImageView.contentMode = .scaleAspectFit
        containerView.addSubview(titleImageView)
        
        navigationItem.titleView = containerView
    }
    
    private func setupLeftButton(title: String?) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 34))
        let image = UIImage(named: "dropArrow")!.withRenderingMode(.alwaysTemplate)
        let label = UILabel()
        let imageView = UIImageView(image: image)
        let somespace: CGFloat = 5
        
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .buttonDark()
        label.textColor = .buttonDark()
        label.text = title
               
        customView.addSubview(label)
        customView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            label.topAnchor.constraint(equalTo: customView.topAnchor),
            label.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            label.widthAnchor.constraint(equalToConstant: label.contentWidthLimitation(maxWidth: 90))
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: somespace),
            imageView.topAnchor.constraint(equalTo: customView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 15)
        ])
        customView.backgroundColor = .red
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
    }
    
    private func setupRightButton() {
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        addBarItem.tintColor = .buttonDark()
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc private func addPhoto() {
        
    }
}

extension ContentViewController: ContentViewControllerViewModelViewModel {
    
    func loadingDataDidFinished(title: String?) {
        if let title = title {
            self.title = title
        }
        
        self.collectionView.reloadData()
    }
}
