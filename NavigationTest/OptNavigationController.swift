//
//  OptNavigationController.swift
//  NavigationTest
//
//  Created by Sergii Sukhanov on 24.07.2020.
//  Copyright © 2020 Serge Sukhanov. All rights reserved.
//

import UIKit

class OptNavigationController<T>: UINavigationController {
  typealias ViewControllerCreation = (T) -> UIViewController
  
  private var modelsStack: [T] = []
  private var viewControllerCreation: ViewControllerCreation = { _ in UIViewController() }

  convenience init(rootModel: T, viewControllerCreation: @escaping ViewControllerCreation) {
    let rootViewController = viewControllerCreation(rootModel)
    self.init(rootViewController: rootViewController)
    
    modelsStack = [rootModel]
    self.viewControllerCreation = viewControllerCreation
  }
  
  func pushViewController(with model: T, animated: Bool) {
    modelsStack.append(model)
    viewControllers = viewControllers.suffix(1)
    let viewController = viewControllerCreation(model)
    super.pushViewController(viewController, animated: animated)
  }
  
  override func popViewController(animated: Bool) -> UIViewController? {
    let lastViewController = super.popViewController(animated: true)

    if !modelsStack.isEmpty {
      modelsStack.removeLast()
    }

    let lastButOneModel = lastButOne(from: modelsStack)
    let viewControllerForLastButOneModel = viewControllerCreation(from: lastButOneModel)
    insertInTheBeginningOfNavigationStack(viewController: viewControllerForLastButOneModel)

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
