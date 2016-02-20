//
//  MRCollectionViewFlowLayout.swift
//  Swift_CardScroll
//
//  Created by Asuna on 16/1/30.
//  Copyright © 2016年 Asuna. All rights reserved.
//

import UIKit

class MRCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
        
        let itemWidth = (324.0/750.0) * UIScreen.mainScreen().bounds.width
        let itemHeight = (324.0/750.0) * UIScreen.mainScreen().bounds.height
        itemSize = CGSizeMake(itemWidth, itemHeight);
        
        let width = UIScreen.mainScreen().bounds.size.width*0.5 - itemSize.width*0.5
        sectionInset = UIEdgeInsetsMake(0, width,0,width + 10.0 )
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElementsInRect(rect)
        
        let centerX = collectionView!.contentOffset.x + collectionView!.frame.size.width*0.5
        
        for attrs in array! {
            let delta = abs(attrs.center.x - centerX)
            
            let scale = (1 - delta/(2*collectionView!.frame.size.width))
            attrs.transform = CGAffineTransformMakeScale(scale, scale)
        }
        
        return array
    }
    
    override func targetContentOffsetForProposedContentOffset(var proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var rect:CGRect = CGRectMake(0, 0, 0, 0)
        rect.origin.y = 0.0
        rect.origin.x = proposedContentOffset.x
        rect.size = (collectionView?.frame.size)!
        
        let array = super.layoutAttributesForElementsInRect(rect)
        let centerX = proposedContentOffset.x + collectionView!.frame.size.width*0.5

        var minDelta = MAXFLOAT
        
        
        for attrs in array! {
            if  abs(minDelta) > Float(abs(attrs.center.x - centerX) ) {
                minDelta = Float(attrs.center.x - centerX)
            }
        }
        
        proposedContentOffset.x = proposedContentOffset.x + CGFloat(minDelta)
        return proposedContentOffset
    }

}
