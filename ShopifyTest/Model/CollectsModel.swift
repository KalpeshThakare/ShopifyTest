//
//  CollectsModel.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-11.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import Foundation

class CollectsModel: Decodable
{
    var collects : [productCollection]
}

class productCollection: Decodable
{
    var id : Int
    var collection_id : Int
    var product_id : Int
}
