//
//  MobileListModels.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct Mobile {
  /// This structure represents a use case
  struct Mobile {
    /// Data struct sent to Interactor
    struct Request {
    }
    /// Data struct sent to Presenter
    struct Response {
        let model: [MobileEntity]
    }
    /// Data struct sent to ViewController
    struct ViewModel {
        var displayMobileModels: [DisplayMobileModel]
        
        struct DisplayMobileModel {
            let id: Int
            let rating: Double
            let thumbImageURL: String
            let price: Double
            let name: String
            let description: String
            var favouriteStatus: Bool?
        }
    }
  }
  
    struct SetFavorite {
      struct Request {
        let indexPathCell: IndexPath
      }
      /// Data struct sent to Presenter
      struct Response {
        let model: [MobileEntity]
      }
      /// Data struct sent to ViewController
      struct ViewModel {
       
      }
    }
  
  struct ButtonStatus {
    struct Request {
      var favouriteBtn: UIButton
      var allBtn: UIButton
      let repeateBtn: Bool
    }
    /// Data struct sent to Presenter
    struct Response {
      let model: [MobileEntity]
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      
    }
  }
  
  struct SendItem {
    
    struct Request {
       let indexPathCell: IndexPath
    }
    /// Data struct sent to Presenter
    struct Response {
      let item: MobileEntity
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let item: MobileEntity
    }
  }
  
}
struct Value {
  enum Identifier: String {
    case showMobileDetail = "showMobileDetail"
  }
}

struct Sorting {
  struct Request {
    var type: String
  }
  struct Response {
    
  }
  struct ViewModel {
   
  }
  enum Sort: String {
    case PriceHighToLow = "high"
    case PriceLowToHigh = "low"
    case Rating = "rating"
  }
}


