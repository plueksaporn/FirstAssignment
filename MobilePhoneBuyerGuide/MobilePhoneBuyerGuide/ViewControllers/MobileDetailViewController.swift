//
//  MobileDetailViewController.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class MobileDetailViewController: UIViewController {
    var detail :Mobiles?
    @IBOutlet weak var mLabelPrice: UILabel!
    @IBOutlet weak var mLabelRating: UILabel!
    @IBOutlet weak var mTextDes: UITextView!
    var mobileId:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetData()
    }
    
    func SetData(){
        guard let detail = detail else { return }
        mTextDes.text = detail.description
        mLabelPrice.text = "Price:$\(String(detail.price))"
        mLabelRating.text = "Rating:\(String(detail.rating))"
        mobileId = detail.id
        self.title = detail.name
        
    }
    
    
    

    
}
