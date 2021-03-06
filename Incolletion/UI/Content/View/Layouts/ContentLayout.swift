//
//  ContentLayout.swift
//  Incolletion
//
//  Created by Анатолий Ем on 01.02.2021.
//

import UIKit

enum ContentLayoutType {
    case defaultType
    case imagePickerType
}

class ContentLayout: UICollectionViewLayout {
    
    var contentBounds = CGRect.zero
    var cache = [UICollectionViewLayoutAttributes]()
    
    var layoutType: ContentLayoutType = .defaultType

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        // Reset cached information.
        cache.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)

        let count = collectionView.numberOfItems(inSection: 0)

        var currentIndex = 0
        var lastFrame: CGRect = .zero

        
        let fraction: CGFloat
        switch layoutType {
        case .defaultType:
            fraction = 1.0 / 3.0
        case .imagePickerType:
            fraction = 1.0 / 4.0
        }
        
        let cvWidth = collectionView.bounds.size.width
        let rowHeight = cvWidth * fraction
        while currentIndex < count {
            let segmentFrame = CGRect(x: 0, y: lastFrame.maxY + 1.0, width: cvWidth, height: rowHeight)

            var segmentRects = [CGRect]()
            
            switch layoutType {
            case .defaultType:
                segmentRects = sliceIntoThreeParts(segmentFrame: segmentFrame, fraction: fraction)
            case .imagePickerType:
                segmentRects = sliceIntoFourParts(segmentFrame: segmentFrame, fraction: fraction)
            }
            

            // Create and cache layout attributes for calculated frames.
            for rect in segmentRects {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
                attributes.frame = rect

                cache.append(attributes)
                contentBounds = contentBounds.union(lastFrame)

                currentIndex += 1
                lastFrame = rect
            }
        }
    }

    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()

        // Find any cell that sits within the query rect.
        guard let lastIndex = cache.indices.last,
              let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }

        for attributes in cache[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }

        for attributes in cache[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }

        return attributesArray
    }

    // Perform a binary search on the cached attributes array.
    private func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }

        let mid = (start + end) / 2
        let attr = cache[mid]

        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }
    
    private func sliceIntoThreeParts(segmentFrame: CGRect, fraction: CGFloat) -> [CGRect] {
        let horizontalFirstSlices = segmentFrame.dividedIntegral(fraction: fraction, from: .minXEdge)
        let horizontalSecondSlices = horizontalFirstSlices.second.dividedIntegral(fraction: 0.5, from: .minXEdge)
         
        return [
            horizontalFirstSlices.first,
            horizontalSecondSlices.first,
            horizontalSecondSlices.second
        ]
    }
    
    private func sliceIntoFourParts(segmentFrame: CGRect, fraction: CGFloat) -> [CGRect] {
        let horizontalFirstSlices = segmentFrame.dividedIntegral(fraction: fraction, from: .minXEdge)
        let horizontalSecondSlices = horizontalFirstSlices.second.dividedIntegral(fraction: 1.0 / 3.0, from: .minXEdge)
        let horizontalThirdSlices = horizontalSecondSlices.second.dividedIntegral(fraction: 0.5, from: .minXEdge)
         
        return [
            horizontalFirstSlices.first,
            horizontalSecondSlices.first,
            horizontalThirdSlices.first,
            horizontalThirdSlices.second
        ]
    }

}
