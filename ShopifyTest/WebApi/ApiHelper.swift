//
//  ApiHelper.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-10.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


class webserviceHelper: NSObject
{
    private let manager = NetworkReachabilityManager(host: "www.google.com")
    
    func isNetworkReachable() -> Bool
    {
        return manager?.isReachable ?? false
    }
    
    static let sharedInstance = webserviceHelper()
    
    
    
    
    // POST REQUEST
    
    func getData(URL: String, parameterDict: [String: Any], methodType:HTTPMethod, headerDict: [String: String]?,Encoding:ParameterEncoding, SuccessBlock: @escaping (Data?) -> Void, FailureMessage:@escaping (String) -> Void)-> Void
    {
        print("URL: \(URL)")
        print("Body: \(parameterDict)")
        print("Method Type : \(methodType)")
        print("headers: \(headerDict)")
        
        if self.isNetworkReachable()
        {
            request(URL, method: methodType, parameters: parameterDict, encoding: Encoding, headers: headerDict).responseJSON
                {
                    (response) in
                    
                    
                    let code = response.response?.statusCode
                    print("STATUS CODE: \(String(describing: code))")
                    
                    if (code == 200)
                    {
                        if let ResponseData = response.data
                        {
                            SuccessBlock(ResponseData)
                        }
                        else
                        {
                            FailureMessage("\(String(describing: response.response?.statusCode.description))  \n Please try again")
                        }
                    }
                    else
                    {
                        if (code == 401)
                        {
                            FailureMessage("Unauthorized \n Please try again")
                        }
                        else if (code?.description == nil)
                        {
                            FailureMessage("Please check your internet \n and try again")
                        }
                        else
                        {
                            if let JSONDict:[String:Any] = response.result.value as? [String : Any]
                            {
                                if let errorMessage:[String] = (JSONDict["errors"] as? [String])
                                {
                                    FailureMessage(errorMessage.first!)
                                }
                                else
                                {
                                    FailureMessage("The service is temporarily unavailable. \n Please try after some time")
                                }
                            }
                            else
                            {
                                FailureMessage("The service is temporarily unavailable. \n Please try after some time")
                            }
                        }
                        
                    }
                    
            }
            
        }  // If Network Reachable else
        else
        {
            FailureMessage("No internet data available, please check your data connection and try again")
        }
    }
    
    
    //---------------------------------------------------------------------
    
    
}


