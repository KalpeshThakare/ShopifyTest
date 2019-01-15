//
//  ApiUrl.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-10.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import Foundation
import Alamofire

private let url_Base = "https://shopicruit.myshopify.com/admin/"




//MARK: URLs

private let url_AllCollection = "custom_collections.json"
private let url_Collects = "collects.json"
private let url_Products = "products.json"


//MARK: URL Structures

struct ApiURL
{
    static let allCollection = url_Base + url_AllCollection
    static let collects = url_Base + url_Collects
    static let products = url_Base + url_Products

}


func ApiParameterDict() -> Parameters
{
    var parameterDict = Parameters()
    parameterDict["page"] = 1
    parameterDict["access_token"] = "c32313df0d0ef512ca64d5b336a0d7c6"
    
    
    return parameterDict
}
