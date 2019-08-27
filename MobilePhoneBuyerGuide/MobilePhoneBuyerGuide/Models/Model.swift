//
//  Model.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Mobiles {
    let rating:Double
    let id:Int
    let thumbImageURL:String
    let price:Double
    let brand:String
    let name:String
    let description:String
}

struct Images {
    let mobileId:Int
    let id:Int
    let url:String
}
