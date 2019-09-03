//
//  MobileDetailInteractor.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileDetailInteractorInterface {
  func getImageData(request: MobileDetail.ShowDetail.Request)
  var model: [ImageEntity] { get set }
  var item: MobileEntity? { get set }
}

class MobileDetailInteractor: MobileDetailInteractorInterface {
  var item: MobileEntity?
  var presenter: MobileDetailPresenterInterface!
  var worker: MobileDetailWorker?
  var model: [ImageEntity] = []
  
  func getImageData(request: MobileDetail.ShowDetail.Request) {
    guard let item = item else {
      return
    }
    worker?.getImageData(mobileItem: item) { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
        guard let model = self?.model else {
         return
        }
        let response = MobileDetail.ShowDetail.Response(
          model: model,
          rating: item.rating,
          price: item.price,
          name: item.name,
          description: item.description)
        self?.presenter.presentMobileDetail(response: response)
      }
    }
  }
}
