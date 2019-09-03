//
//  MobileListInteractor.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileListInteractorInterface {
  func getMobileData(request: Mobile.Mobile.Request)
  func setFavourite(request: Mobile.SetFavorite.Request)
  func getFavouriteList(request: Mobile.ButtonStatus.Request)
  func getAllList(request: Mobile.ButtonStatus.Request)
  func sendMobileDetail(request: Mobile.SendItem.Request)
  func sorting(request: Sorting.Request)
  var model: [MobileEntity] { get set }
  var item: MobileEntity? { get set }
}

class MobileListInteractor: MobileListInteractorInterface {
    var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var model: [MobileEntity] = []
  var favouriteList: [MobileEntity] = []
  var mobileList: [MobileEntity] = []
  var item: MobileEntity?
  // MARK: - Business logic

  func getMobileData(request: Mobile.Mobile.Request) {
    worker?.getMobileList { [weak self] in
      if case let Result.success(data) = $0 {
        self?.model = data
        }
        guard let model = self?.model else {
            return
        }
         let response = Mobile.Mobile.Response(model: model)
        self?.presenter.presentMobileList(response: response)
    }
  }
  
  func setFavourite(request: Mobile.SetFavorite.Request) {
    if model[request.indexPathCell.row].favouriteStatus == true {
      model[request.indexPathCell.row].favouriteStatus = false
    }else{
      model[request.indexPathCell.row].favouriteStatus = true
    }
    let response = Mobile.Mobile.Response(model: model)
    self.presenter.presentMobileList(response: response)
  }
  
  func getFavouriteList(request: Mobile.ButtonStatus.Request) {
    request.favouriteBtn.isSelected = !request.favouriteBtn.isSelected
    let favouriteStatus = model.filter {
      $0.favouriteStatus ?? false
      
    }
    if request.favouriteBtn.isSelected == true {
      request.allBtn.isSelected = false
      if request.repeateBtn != false {
        mobileList = model
      }
    }else{
      request.favouriteBtn.isSelected = !request.favouriteBtn.isSelected
    }
    favouriteList = favouriteStatus
    model = favouriteList
    let response = Mobile.Mobile.Response(model: model)
    self.presenter.presentMobileList(response: response)
  }
  
  func getAllList(request: Mobile.ButtonStatus.Request) {
     request.allBtn.isSelected = !request.allBtn.isSelected
    if  request.allBtn.isSelected == true {
      request.favouriteBtn.isSelected = false
      model = mobileList
    }else{
      request.allBtn.isSelected = !request.allBtn.isSelected
    }
    let response = Mobile.Mobile.Response(model: model)
    self.presenter.presentMobileList(response: response)
  }
  
  func sendMobileDetail(request: Mobile.SendItem.Request) {
    item = model[request.indexPathCell.row]
  }
  
  func sorting(request: Sorting.Request) {
    model.sort { (lhs: MobileEntity, rhs: MobileEntity) -> Bool in
      if request.type == "low" {
        return lhs.price < rhs.price
      }else if request.type == "high" {
        return lhs.price > rhs.price
      }else {
        return lhs.rating > rhs.rating
      }
    }
    let response = Mobile.Mobile.Response(model: model)
    self.presenter.presentMobileList(response: response)
  }
}
