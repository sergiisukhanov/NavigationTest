//
//  ProductModel.swift
//  NavigationTest
//
//  Created by Sergii Sukhanov on 24.07.2020.
//  Copyright © 2020 Serge Sukhanov. All rights reserved.
//

import Foundation

class ProductModel {
  var name: String
  var iconIdentifier: String
  
  var recommendedProducts: [ProductModel]
  
  init(name: String, iconIdentifier: String, recommendedProducts: [ProductModel]) {
    self.name = name
    self.iconIdentifier = iconIdentifier
    self.recommendedProducts = recommendedProducts
  }
}

// MARK: - Mock data creation
extension ProductModel {
  static func prepareMockProducts() -> [ProductModel] {
    let burger = ProductModel(name: "Burger", iconIdentifier: "burger_icon", recommendedProducts: [])
    let cola = ProductModel(name: "Cola", iconIdentifier: "cola_icon", recommendedProducts: [])
    let frenchFries = ProductModel(name: "French fries", iconIdentifier: "french_fries_icon", recommendedProducts: [])
    
    burger.recommendedProducts = [cola, frenchFries]
    cola.recommendedProducts = [burger, frenchFries]
    frenchFries.recommendedProducts = [burger, cola]
    
    return [burger, cola, frenchFries]
  }
}
