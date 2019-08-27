//
//  Model.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Mobiles:Codable {
    let rating:Double
    let id:Int
    let thumbImageURL:String
    let price:Double
    let brand:String
    let name:String
    let description:String
}

struct Images:Codable{
    let mobileId:Int
    let id:Int
    let url:String
}



//extension Mobiles{
//    init(json : JSON) {
//        rating = Double(json["rating"].intValue)
//        id = json["id"].intValue
//        thumbImageURL = json["thumbImageURL"].stringValue
//        price = Double(json["price"].intValue)
//        brand = json["brand"].stringValue
//        name = json["name"].stringValue
//        description = json["description"].stringValue
//    }
//}
