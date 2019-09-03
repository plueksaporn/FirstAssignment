//
//  MobileDetailViewController.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileDetailViewControllerInterface: class {
  func displayMobileDetail(viewModel: MobileDetail.ShowDetail.ViewModel)
  
}

class MobileDetailViewController: UIViewController, MobileDetailViewControllerInterface, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
  var interactor: MobileDetailInteractorInterface!
  var router: MobileDetailRouter!
  @IBOutlet weak var mLabelPrice: UILabel!
  @IBOutlet weak var mLabelRating: UILabel!
  @IBOutlet weak var mTextDes: UITextView!
  @IBOutlet weak var mCollection: UICollectionView!
  var images: [ImageEntity] = [] {
    didSet {
      mCollection.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  private func configure(viewController: MobileDetailViewController) {
    let router = MobileDetailRouter()
    router.viewController = viewController

    let presenter = MobileDetailPresenter()
    presenter.viewController = viewController

    let interactor = MobileDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MobileDetailWorker(store: MobileDetailStore())

    viewController.interactor = interactor
    viewController.router = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
  }

  func doSomethingOnLoad() {
      let request = MobileDetail.ShowDetail.Request(itemList: nil)
      interactor.getImageData(request: request)
  }
  
  func displayMobileDetail(viewModel: MobileDetail.ShowDetail.ViewModel) {
    images = viewModel.model
    mLabelPrice.text = viewModel.price
    mLabelRating.text = viewModel.rating
    mTextDes.text = viewModel.description
  }
  
  @IBAction func unwindToMobileDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
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
