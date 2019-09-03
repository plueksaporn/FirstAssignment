//
//  MobileDetailWorker.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileDetailStoreProtocol {
  func getData(mobileItem: MobileEntity, _ completion: @escaping (Swift.Result<[ImageEntity],Error>) -> Void)
}

class MobileDetailWorker {

  var store: MobileDetailStoreProtocol

  init(store: MobileDetailStoreProtocol) {
    self.store = store
  }

  func getImageData(mobileItem: MobileEntity, _ completion: @escaping (Swift.Result<[ImageEntity], Error>) -> Void) {
    store.getData(mobileItem: mobileItem) {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
}
