//
//  MobileListViewController.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileListViewControllerInterface: class {
  func displayMobileList(viewModel: Mobile.Mobile.ViewModel)  
  func setFavourite(index: IndexPath)
}

class MobileListViewController: UIViewController, MobileListViewControllerInterface, UITableViewDelegate, UITableViewDataSource {
  var mobileData: [Mobile.Mobile.ViewModel.DisplayMobileModel] = [] {
        didSet {
            mTable.reloadData()
        }
    }
  var interactor: MobileListInteractorInterface!
  var router: MobileListRouter!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var mTable: UITableView!
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration
  private func configure(viewController: MobileListViewController) {
    let router = MobileListRouter()
    router.viewController = viewController

    let presenter = MobileListPresenter()
    presenter.viewController = viewController

    let interactor = MobileListInteractor()
    interactor.presenter = presenter
    interactor.worker = MobileListWorker(store: MobileListStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    mTable.estimatedRowHeight = CGFloat(500)
    mTable.rowHeight = UITableView.automaticDimension
    doMobileListOnLoad()
    let sortBtn = UIBarButtonItem(title: "Sort", style: .plain, target: self, action:#selector(onSortBtnClick(_:)) )
    self.navigationItem.rightBarButtonItem = sortBtn
  }
 
  func doMobileListOnLoad() {
    let request = Mobile.Mobile.Request()
    interactor.getMobileData(request: request)
  }
  
  func displayMobileList(viewModel: Mobile.Mobile.ViewModel) {
    mobileData = viewModel.displayMobileModels
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return interactor.model.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = mTable.dequeueReusableCell(withIdentifier: "cell") as! CustomMobileListViewCell
    let mobilesData: Mobile.Mobile.ViewModel.DisplayMobileModel  = mobileData[indexPath.item]
    cell.MappingData(mobiles:mobilesData)
    cell.delegate = self
    if self.allBtn.isSelected == false {
      cell.mFavourite.isHidden = true
    }else{
      cell.mFavourite.isHidden = false
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      setFavourite(index: indexPath)
      onFavBtnClick(true as AnyObject)
    }
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    if self.favBtn.isSelected == true {
      return .delete
    }else {
      return .none
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let request = Mobile.SendItem.Request(indexPathCell: indexPath)
    interactor.sendMobileDetail(request: request)
    router.navigateToSomewhere(item: interactor.item)
  }
  
  func setFavourite(index: IndexPath) {
      let request = Mobile.SetFavorite.Request(indexPathCell: index)
      interactor.setFavourite(request: request)
  }

  @IBAction func onFavBtnClick(_ sender: AnyObject?) {
    let request = Mobile.ButtonStatus.Request(favouriteBtn: favBtn, allBtn: allBtn, repeateBtn: (sender != nil))
    interactor.getFavouriteList(request: request)
    mTable.reloadData()
  }
  
  @IBAction func onAllBtnClick(_ sender: UIButton) {
    let request = Mobile.ButtonStatus.Request(favouriteBtn: favBtn, allBtn: allBtn, repeateBtn: false)
    interactor.getAllList(request: request)
    mTable.reloadData()
  }
  
  @IBAction func onSortBtnClick(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Sort", message: "", preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Price high to low", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.interactor.sorting(request: Sorting.Request(type: "high"))}))
    alert.addAction(UIAlertAction(title: "Price low to high", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.interactor.sorting(request: Sorting.Request(type: "low"))}))
    alert.addAction(UIAlertAction(title: "Rating", style: UIAlertAction.Style.default, handler:{ (alert: UIAlertAction!) in self.interactor.sorting(request: Sorting.Request(type: "rating"))}))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler:nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
}
