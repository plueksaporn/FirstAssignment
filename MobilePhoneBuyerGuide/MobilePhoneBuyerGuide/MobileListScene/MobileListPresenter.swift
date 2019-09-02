//
//  MobileListPresenter.swift
//  MobilePhoneBuyerGuide
//
//  Created by Plueksaporn Kattiyawong on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol MobileListPresenterInterface {
  func presentSomething(response: MobileList.Something.Response)
}

class MobileListPresenter: MobileListPresenterInterface {
  weak var viewController: MobileListViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: MobileList.Something.Response) {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.

    let viewModel = MobileList.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
}
