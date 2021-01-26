//
//  ContentCollectionView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class ContentCollectionView: UICollectionView {
    
    var viewModel: ContentCollectionViewViewModel?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewLayout()) {
        let rowLayout = ContentCollectionViewLayout()
        super.init(frame: frame, collectionViewLayout: rowLayout)
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alwaysBounceVertical = true
        indicatorStyle = .white
        backgroundColor = .mainWhite()
        
        delegate = self
        dataSource = self
        
        showsHorizontalScrollIndicator = false
        
        register(ContentCollectionViewCell.self,
                 forCellWithReuseIdentifier:ContentCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentCollectionView: UICollectionViewDelegate {
    
}

extension ContentCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.numberOfItemsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reuseId, for: indexPath) as! ContentCollectionViewCell
        cell.viewModel = self.viewModel?.cellForItemAt(indexPath)
        cell.viewModel?.delegate = cell as? ContentCollectionViewCellViewModelDelegate
        cell.viewModel?.fetchMedia()
        return cell
    }
}
