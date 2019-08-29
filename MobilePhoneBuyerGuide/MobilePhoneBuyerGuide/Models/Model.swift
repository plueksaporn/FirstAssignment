//
//  Model.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import SwiftyJSON

class Mobiles:Codable {
    let rating:Double
    let id:Int
    let thumbImageURL:String
    let price:Double
    let brand:String
    let name:String
    let description:String
    var favouriteStatus:Bool?
}

struct ImagesElement: Codable {
    let id: Int
    let url: String
    let mobileID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, url
        case mobileID = "mobile_id"
    }
}

typealias Images = [ImagesElement]







