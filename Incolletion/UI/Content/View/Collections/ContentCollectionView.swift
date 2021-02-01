//
//  ContentCollectionView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class ContentCollectionView: UICollectionView {
    
    lazy var viewModel = makeViewModel()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewLayout()) {
        let rowLayout = ContentLayout()
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
        return self.viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reuseId, for: indexPath) as! ContentCollectionViewCell
        let mediaId = self.viewModel.cellForItemAt(indexPath)
        cell.viewModel.delegate = cell as? ContentCollectionViewCellViewModelDelegate
        cell.viewModel.fetchMedia(accessToken: self.viewModel.getAccessToken()!, mediaId: mediaId)
        return cell
    }
}
