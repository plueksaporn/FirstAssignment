//
//  CustomCollectionViewCell.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 29/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
     @IBOutlet weak var mImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func MapData(url:String) {
        let firstWord = url.components(separatedBy: ".")
        let word:String? = firstWord.first
        if word == "www" {
            mImageView.kf.setImage(with: URL(string: "https://\(firstWord.joined(separator: "."))" ))
        }else{
            mImageView.kf.setImage(with: URL(string: url))
        }
       
    }
}
