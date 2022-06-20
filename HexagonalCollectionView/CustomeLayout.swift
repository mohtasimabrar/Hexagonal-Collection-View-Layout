//
//  CustomeLayout.swift
//  HexagonalCollectionView
//
//  Created by Mohtasim Abrar Samin on 29/3/22.
//

import UIKit

protocol CustomLayoutDelagate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CustomeLayout: UICollectionViewLayout {
    weak var delegate: CustomLayoutDelagate?
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        let doubleColumnWidth = contentWidth / CGFloat(numberOfColumns)
        let singleColumnWidth = contentWidth
        var xOffset:[CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * doubleColumnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let cellHeight = delegate?.collectionView( collectionView, heightForCellAtIndexPath: indexPath) ?? 160
            let height = cellPadding * 2 + cellHeight
            if ((item + 1) % 3 != 0 ) {
                let frame = CGRect(x: xOffset[column],
                                   y: yOffset[column],
                                   width: doubleColumnWidth,
                                   height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + (3/4)*height
                
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            } else {
                
                let frame = CGRect(x: xOffset[0],
                                   y: yOffset[column],
                                   width: singleColumnWidth,
                                   height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + (3/4)*height
                yOffset[column + 1] = yOffset[column + 1] + (3/4)*height
                
                //column = column < (numberOfColumns - 1) ? (column + 1) : 0
                
            }
            
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
