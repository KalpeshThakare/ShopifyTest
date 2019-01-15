//
//  ProductsModel.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-11.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import Foundation

class ProductsModel: Decodable
{
    var products : [allProducts]
}

class allProducts: Decodable
{
    
    var id : Int
    var title : String
    var body_html : String
    var vendor : String
    var product_type : String
    var handle : String
    
    
    var variants : [allVariants]
    
    var options : [allOptions]
    
    var images : [allImages]
    
    var image : Image
    
}
    

class allVariants: Decodable
{
    
    var id : Int
    var product_id : Int
    var title : String
    var price : String
    var inventory_item_id : Int
    var inventory_quantity : Int
    var old_inventory_quantity : Int
    var admin_graphql_api_id : String
    
}

class allOptions: Decodable
{
    
    var id : Int
    var product_id : Int
    var name : String
    
}

class allImages: Decodable
{
    
    var id : Int
    var product_id : Int
    var src : String
    
}

class Image: Decodable
{
    var id : Int
    var product_id : Int
    var src : String
    
}
