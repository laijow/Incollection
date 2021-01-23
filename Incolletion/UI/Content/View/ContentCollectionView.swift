//
//  ContentCollectionView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class ContentCollectionView: UICollectionView {
    
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
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.reuseId, for: indexPath) as! ContentCollectionViewCell
        return cell
    }
    
}
