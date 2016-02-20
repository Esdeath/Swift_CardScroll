//
//  MRCollectionViewCell.swift
//  Swift_CardScroll
//
//  Created by Asuna on 16/1/30.
//  Copyright © 2016年 Asuna. All rights reserved.
//

import UIKit

class MRCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var hudView: UIView!
    
    private var myContext = 0

    override func awakeFromNib() {
        selectedButton.userInteractionEnabled = false        
    }
    
    
    func showBorders(isShow:Bool) {
        if isShow {
            self.layer.borderWidth = 2;
            self.layer.borderColor = UIColor.greenColor().CGColor
        } else  {
            self.layer.borderWidth = 0;
        }
    }
}
