//
//  ViewController.swift
//  NavigationTest
//
//  Created by Serge Sukhanov on 05.07.2020.
//  Copyright © 2020 Serge Sukhanov. All rights reserved.
//

import UIKit

extension UIViewController {
  private static func instantiateFromStoryboardPrivate<T: UIViewController>() -> T {
    let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
    return storyboard.instantiateInitialViewController() as! T
  }
  
  static func instantiateFromStoryboard() -> Self {
    return instantiateFromStoryboardPrivate()
  }
}

class ViewController: UIViewController {
  @IBOutlet private var collectionView: UICollectionView!
  private var productsModel = [ProductModel]()
  
  override func viewDidLoad() {
    collectionView.dataSource = self
    collectionView.delegate = self
    
    productsModel = ProductModel.prepareMockProducts()
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return productsModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
      return UICollectionViewCell()
    }
    
    let product = productsModel[indexPath.row]
    cell.configure(with: product)
    return cell
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let productModel = productsModel[indexPath.row]
    let navigationController = OptNavigationController(
      rootModel: productModel,
      viewControllerCreation: { productModel in ProductViewController.instantiate(with: productModel) }
    )
    present(navigationController, animated: true)
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 120.0, height: 56.0)
  }
}
