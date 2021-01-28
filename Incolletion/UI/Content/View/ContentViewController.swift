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
        
        self.collectionView.reloadData()
    }
}
