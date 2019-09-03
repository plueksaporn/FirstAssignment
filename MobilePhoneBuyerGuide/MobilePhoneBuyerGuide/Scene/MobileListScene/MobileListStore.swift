//
//  MobileListStore.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
/*

 The MobileListStore class implements the MobileListStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class MobileListStore: MobileListStoreProtocol {
  var baseURL:String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  func getData(completion: @escaping (Swift.Result<[MobileEntity], Error>) -> Void) {
    Alamofire.request("\(baseURL)")
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success:
          do {
            let mobiles = try JSONDecoder().decode([MobileEntity].self, from: response.data!)
            completion(.success(mobiles))
            
          } catch (let error) {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
    // Simulates an asynchronous background thread that calls back on the main thread after 2 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      //      completion(Result.success(Entity()))
    }
  }
}
