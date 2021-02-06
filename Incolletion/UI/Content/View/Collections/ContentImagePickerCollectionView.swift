//
//  ContentImagePickerCollectionView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 01.02.2021.
//

import UIKit

class ContentImagePickerCollectionView: UICollectionView {
    
    private lazy var viewModel = makeViewModel()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewLayout()) {
        let rotLayout = ContentLayout()
        rotLayout.layoutType = .imagePickerType
        super.init(frame: frame, collectionViewLayout: rotLayout)
                
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alwaysBounceVertical = true
        indicatorStyle = .white
        backgroundColor = .mainWhite()
        
        viewModel.delegate = self
        delegate = self
        dataSource = self
        
        showsHorizontalScrollIndicator = false
        
        register(ContentImagePickerCollectionViewCell.self,
                 forCellWithReuseIdentifier:ContentImagePickerCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentImagePickerCollectionView: UICollectionViewDelegate {
    
}

extension ContentImagePickerCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ContentImagePickerCollectionViewCell.reuseId, for: indexPath) as! ContentImagePickerCollectionViewCell
        let photo = viewModel.cellForItemAt(indexPath)
        cell.set(photo)
        
        return cell
    }
}

extension ContentImagePickerCollectionView: ContentImagePickerCollectionViewModelDelegate {
    func loadDidFinishing() {
        reloadData()
    }
}
