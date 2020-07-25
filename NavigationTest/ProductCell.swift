//
//  ProductCell.swift
//  NavigationTest
//
//  Created by Sergii Sukhanov on 24.07.2020.
//  Copyright © 2020 Serge Sukhanov. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
  @IBOutlet private var productName: UILabel!
  
  func configure(with product: ProductModel) {
    productName.text = product.name
  }
}
