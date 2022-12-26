//
//  ShopDataModel.swift
//  PathaoShop
//
//  Created by MacBook Pro on 22/12/22.
//

import Foundation

struct ShopDataModel: Codable {
    let shop_name: String?
    let items: [Item]?
}

struct Item: Codable {
    let name: String?
    let description: String?
    let price: Int64?
    let image: String?
}
