//
//  AllCollectionsModel.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-10.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import Foundation

class AllCollectionsModel: Decodable
{
    var custom_collections: [allCollections]
}

class allCollections: Decodable
{
    var id : Int
    var handle : String
    var title : String
    var body_html : String
    var image : collImage
}

class collImage: Decodable
{
    
    var created_at : String
    var src : String
    
}
