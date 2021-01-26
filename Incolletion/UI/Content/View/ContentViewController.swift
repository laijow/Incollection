//
//  ContentViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 10.01.2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    private var collectionView: ContentCollectionView!
    
    private let viewModel: ContentViewControllerViewModel
    
    init(viewModel: ContentViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.loadingData()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView = ContentCollectionView(frame: view.bounds)
        view.addSubview(collectionView)
    }
}

extension ContentViewController: ContentViewControllerViewModelViewModel {
    
    func loadingDataDidFinished(title: String?) {
        if let title = title {
            self.title = title
        }
        collectionView.viewModel = self.viewModel.getCollectionViewViewModel()
        
        self.collectionView.reloadData()
    }
}
