//
//  MobileDetailEntity.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

struct ImageEntity: Codable {
  let id: Int
  let url: String
  let mobileID: Int
  
  enum CodingKeys: String, CodingKey {
    case id, url
    case mobileID = "mobile_id"
  }
}
