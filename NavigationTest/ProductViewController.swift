//
//  ProductViewController.swift
//  NavigationTest
//
//  Created by Sergii Sukhanov on 24.07.2020.
//  Copyright © 2020 Serge Sukhanov. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
  @IBOutlet private var productName: UILabel!
  @IBOutlet private var productIcon: UILabel!
  @IBOutlet private var collectionView: UICollectionView!
  
  var productModel: ProductModel!
  
  private var recommendedProducts: [ProductModel] {
    return productModel.recommendedProducts
  }
  
  private var optNavigationController: OptNavigationController<ProductModel>? {
    return navigationController as? OptNavigationController<ProductModel>
  }
  
  static func instantiate(with productModel: ProductModel) -> ProductViewController {
    let viewController = ProductViewController.instantiateFromStoryboard()
    viewController.productModel = productModel
    return viewController
  }
  
  override func viewDidLoad() {
    productName.text = productModel.name
    productIcon.text = productModel.iconIdentifier
    
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if GlobalCounter.shared.count < 1000 {
      GlobalCounter.shared.count += 1
      let indexPath = IndexPath(row: 0, section: 0)
      collectionView(collectionView, didSelectItemAt: indexPath)
    } else {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.navigationController?.popViewController(animated: true)
      }
    }
  }
}

extension ProductViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recommendedProducts.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
      return UICollectionViewCell()
    }
    
    let product = recommendedProducts[indexPath.row]
    cell.configure(with: product)
    return cell
  }
}

extension ProductViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let productModel = recommendedProducts[indexPath.row]
    let productViewController = ProductViewController.instantiate(with: productModel)
    optNavigationController?.pushViewController(productViewController, with: productModel, animated: true)
  }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: 120.0, height: 56.0)
  }
}
