//
//  MobileDetailViewController.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class MobileDetailViewControllers: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
   
    
    var detail :Mobiles?
    @IBOutlet weak var mLabelPrice: UILabel!
    @IBOutlet weak var mLabelRating: UILabel!
    @IBOutlet weak var mTextDes: UITextView!
    @IBOutlet weak var mCollection: UICollectionView!
    var mobileId:Int?
    
    let api = APIManager()
    var images: Images = []{
        didSet {
            mCollection.reloadData()
        }
    }
    
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
            switch result {
            case .success(let data):
                self.images = data
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true)
            }
//            self.images = result
//            self.mCollection.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showImage", for: indexPath) as! CustomCollectionViewCell
        let item = self.images[indexPath.row].url
        cell.MapData(url: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height*0.35)
    }
}
    
    
  
    

