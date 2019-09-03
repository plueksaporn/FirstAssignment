//
//  CustomViewCell.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

class CustomMobileListViewCell: UITableViewCell {

    @IBOutlet weak var mRating: UILabel!
    @IBOutlet weak var mPrice: UILabel!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDes: UILabel!
    @IBOutlet weak var mFavourite: UIButton!
    var delegate: MobileListViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func MappingData(mobiles: Mobile.Mobile.ViewModel.DisplayMobileModel) {
        mImage.kf.setImage(with: URL(string: mobiles.thumbImageURL))
        mTitle.text = mobiles.name
        mDes.text = mobiles.description
        mPrice.text = "Price: $\(String(mobiles.price))"
        mRating.text = "Rating: \(String(mobiles.rating))"
        if mobiles.favouriteStatus != nil {
            mFavourite.isSelected = mobiles.favouriteStatus!
        } else {
            mFavourite.isSelected = false
        }
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFavouriteItemClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
      if let indexPath = delegate?.mTable.indexPath(for: self) {
        delegate?.setFavourite(index: indexPath)
      }
    }
}
