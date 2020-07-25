//
//  OptNavigationController.swift
//  NavigationTest
//
//  Created by Sergii Sukhanov on 24.07.2020.
//  Copyright © 2020 Serge Sukhanov. All rights reserved.
//

import UIKit

class OptNavigationController<T>: UINavigationController {
  typealias ViewControllerCreation = (T) -> UIViewController?
  
  private var modelsStack: [T] = []
  private var viewControllerCreation: ViewControllerCreation = { _ in nil }

  convenience init(rootViewController: UIViewController,
                   model: T,
                   viewControllerCreation: @escaping ViewControllerCreation) {
    self.init(rootViewController: rootViewController)
    modelsStack = [model]
    self.viewControllerCreation = viewControllerCreation
  }
  
  func pushViewController(_ viewController: UIViewController, with model: T, animated: Bool) {
    modelsStack.append(model)
    viewControllers = viewControllers.suffix(1)
    super.pushViewController(viewController, animated: animated)
    print(modelsStack.count)
  }
  
  override func popViewController(animated: Bool) -> UIViewController? {
    let lastViewController = super.popViewController(animated: true)

    if !modelsStack.isEmpty {
      modelsStack.removeLast()
    }

    let lastButOneModel = lastButOne(from: modelsStack)
    let viewControllerForLastButOneModel = viewControllerCreation(from: lastButOneModel)
    insertInTheBeginningOfNavigationStack(viewController: viewControllerForLastButOneModel)

    print(modelsStack.count)
    return lastViewController
  }
  
  private func viewControllerCreation(from model: T?) -> UIViewController? {
    guard let model = model else {
      return nil
    }
    
    return viewControllerCreation(model)
  }
  
  private func insertInTheBeginningOfNavigationStack(viewController: UIViewController?) {
    guard let viewController = viewController else {
      return
    }
    
    var navigationStack = viewControllers
    navigationStack = [viewController] + navigationStack
    setViewControllers(navigationStack, animated: false)
  }
  
  private func lastButOne(from array: [T]) -> T? {
    guard array.count >= 2 else {
      return nil
    }
    
    return array[array.count - 2]
  }
}
