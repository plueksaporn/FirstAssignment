//
//  MobileDetailStore.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
/*

 The MobileDetailStore class implements the MobileDetailStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class MobileDetailStore: MobileDetailStoreProtocol {
  func getData(mobileItem: MobileEntity, _ completion: @escaping (Swift.Result<[ImageEntity], Error>) -> Void) {
    let baseURL = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobileItem.id)/images/"
    Alamofire.request("\(baseURL)")
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success:
          do {
            let images = try JSONDecoder().decode([ImageEntity].self, from: response.data!)
            completion(.success(images))
          } catch (let error) {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
    
  }
  

  
  
}
