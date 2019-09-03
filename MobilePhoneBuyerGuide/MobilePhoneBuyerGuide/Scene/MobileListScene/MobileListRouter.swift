//
//  MobileListRouter.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileListRouterInput {
  func navigateToSomewhere(item: MobileEntity?)
}

class MobileListRouter: MobileListRouterInput {
  weak var viewController: MobileListViewController!

  func navigateToSomewhere(item: MobileEntity?) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    guard let MobileDetailViewController = storyBoard.instantiateViewController(withIdentifier: "MobileDetail") as? MobileDetailViewController else {
      return
    }
    MobileDetailViewController.interactor.item = item
    viewController.navigationController?.pushViewController(MobileDetailViewController, animated: true)
  }
  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
//    let someWhereViewController = segue.destination as? MobileDetailViewController
  }
}
