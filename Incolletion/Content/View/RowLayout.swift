//
//  RowLayout.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import Foundation
import UIKit

class RowLayout: UICollectionViewLayout {
    
    private let numbersOfRows = 3
    fileprivate var cellPadding: CGFloat = 2
        
    // constant
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        return collectionView.bounds.width/CGFloat(numbersOfRows) - (CGFloat(numbersOfRows) * cellPadding)
    }
    
    fileprivate var contentHeight: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentHeight = contentWidth
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }

}
