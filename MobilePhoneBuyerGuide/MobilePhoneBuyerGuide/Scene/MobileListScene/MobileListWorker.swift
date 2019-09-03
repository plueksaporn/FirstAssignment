//
//  MobileListWorker.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileListStoreProtocol {
  func getData(completion: @escaping (Swift.Result<[MobileEntity], Error>) -> Void)
}

class MobileListWorker {

  var store: MobileListStoreProtocol

  init(store: MobileListStoreProtocol) {
    self.store = store
  }

  func getMobileList(_ completion: @escaping (Swift.Result<[MobileEntity], Error>) -> Void) {
   
   
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
        completion($0)
    }
  }
  
  
  
  
  
}
