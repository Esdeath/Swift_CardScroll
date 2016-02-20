//
//  ViewController.swift
//  Swift_CardScroll
//
//  Created by Asuna on 16/1/30.
//  Copyright © 2016年 Asuna. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource {
    
    //MARK:属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var numberLabel: UILabel!
    
    var imgArray:[String] = []
    var boolArray:[Bool] = []
    var hubArray:[Bool]  = []
    private   var lastCount:Int = 0
    private var lastSelected:Int = 0
    private let width = 324.0/750.0 * UIScreen.mainScreen().bounds.width
}

//MARK:Lift Circle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValue()
        setupCollectionView()
        setupPageControl()
    }
}


//MARK: private function
extension ViewController {
    private func setupValue() {
        imgArray = ["IMG_0457.jpg","IMG_0458.jpg","IMG_0459.jpg","IMG_0460.jpg","IMG_0461.jpg","IMG_0462.jpg","IMG_0463.jpg","IMG_0464.jpg"]
        boolArray = [true,false,false,false,false,false,false,false]
        hubArray = [true,false,false,false,false,false,false,false]

    }
    
    private func setupCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator   = false
        collectionView.backgroundColor = UIColor.blackColor()
        view.backgroundColor = UIColor.blackColor()
        
        //collectionView.pagingEnabled = true
        
    }
    
    private func setupPageControl() {
        if imgArray.count >= 10 {
            pageControl.hidden = true
            numberLabel.hidden = false
            numberLabel.text = String()
        } else {
            pageControl.hidden = false
            numberLabel.hidden = true
            
        }
        
        pageControl.numberOfPages = imgArray.count
        pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
    }

}

//MARK: collectionViewDataSource
extension ViewController {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:MRCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("mycell", forIndexPath: indexPath) as! MRCollectionViewCell
        
        cell.imageView.image = UIImage(named: imgArray[indexPath.item])
        cell.selectedButton.selected = boolArray[indexPath.item]
        cell.showBorders(cell.selectedButton.selected)
        cell.hudView.hidden = hubArray[indexPath.item]
        return cell
    }
    
}

//MARK: collectionViewDelegate
extension ViewController {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        if lastSelected != indexPath.item {
            boolArray[indexPath.item] = true
            boolArray[lastSelected] = false
            lastSelected = indexPath.item

            collectionView.reloadData()
        }
    }
}

//MARK: scrollViewDelegate
extension ViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let iCount = Int((scrollView.contentOffset.x + 3.0)/(width + 10.0))
        pageControl.currentPage = iCount
        
        if lastCount != iCount {
            hubArray[lastCount] = false
            hubArray[iCount] = true
            lastCount = iCount
            collectionView.reloadData()
        }
    }
}

