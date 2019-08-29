//
//  MobileDetailViewController.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class MobileDetailViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
   
    
    var detail :Mobiles?
    @IBOutlet weak var mLabelPrice: UILabel!
    @IBOutlet weak var mLabelRating: UILabel!
    @IBOutlet weak var mTextDes: UITextView!
    @IBOutlet weak var mCollection: UICollectionView!
//    @IBOutlet weak var pageControl: UIPageControl!
    var mobileId:Int?
    
    let api = APIManager()
    var images: Images = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetData()
        FeedImage(mobileId!)
        
        
    }
    
    func SetData(){
        guard let detail = detail else { return }
        mTextDes.text = detail.description
        mLabelPrice.text = "Price:$\(String(detail.price))"
        mLabelRating.text = "Rating:\(String(detail.rating))"
        mobileId = detail.id
        self.title = detail.name
        
    }
    
    func FeedImage(_ id:Int){
        print(id)
        api.getImages(mobileId: id) { (result) in
            self.images = result
            self.mCollection.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showImage", for: indexPath) as! CustomCollectionViewCell
        let item = self.images[indexPath.row]
        let image = item.url
        print(item)
        cell.mImageView.kf.setImage(with: URL(string: image))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height*0.35)
    }
}
    
    
  
    

