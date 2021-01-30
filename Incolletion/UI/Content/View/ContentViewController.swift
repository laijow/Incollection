//
//  ContentViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 10.01.2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    private var collectionView: ContentCollectionView!
    private var leftBarButtonView: ContentLeftBarButtonView!
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
        leftBarButtonView = ContentLeftBarButtonView(title: title)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonView)
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
    
    func loadingDataDidFinished(title: String) {
        leftBarButtonView.updateTitle(title)
        self.collectionView.reloadData()
    }
}
