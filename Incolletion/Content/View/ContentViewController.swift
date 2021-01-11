//
//  ContentViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 10.01.2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    var collectionView: ContentCollectionView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

// MARK: SwiftUI
import SwiftUI

struct ContentViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ContentViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ContentViewControllerProvider.ContainerView>) -> ContentViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ContentViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ContentViewControllerProvider.ContainerView>) {
            
        }
    }
}
