//
//  MobileDetailRouter.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileDetailRouterInput {
  func navigateToSomewhere()
}

class MobileDetailRouter: MobileDetailRouterInput {
  weak var viewController: MobileDetailViewController!

  func navigateToSomewhere() {
    
  }

  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.interactor.model = viewController.interactor.model
  }
}
