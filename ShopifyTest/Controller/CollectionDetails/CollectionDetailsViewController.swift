//
//  CollectionDetailsViewController.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-10.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class CollectionDetailsViewController: UIViewController {
    
    
    //MARK: VARIABLES
    
    var collectionID = Int()
    
    var productIDArray = [Int]()
    
    var FinalProductsArray = [allProducts]()
    
    //MARK: OUTLETS
    
    @IBOutlet weak var tblView_CollectionDetails: UITableView!
    
    
    //MARK: VIEW METHODS
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        tblView_CollectionDetails.delegate = self
        tblView_CollectionDetails.dataSource = self
        
        tblView_CollectionDetails.estimatedRowHeight = 100
        tblView_CollectionDetails.rowHeight = UITableView.automaticDimension
        
        
        DispatchQueue.main.async
        {
            self.Webservice_GetAllCollections()
        }
        
    }
    
    
    
    //MARK: IBACTIONS
    
    @IBAction func OnClickBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: METHODS
    
    
}



//MARK: TABLEVIEW DELEGATE & DATASOURCE METHODS

extension CollectionDetailsViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return FinalProductsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let collectionCell = tblView_CollectionDetails.dequeueReusableCell(withIdentifier: "details", for: indexPath)as! ColllectionDetailsCell
        
        let productModelObj = FinalProductsArray[indexPath.row]
        
        collectionCell.lbl_ProductTitle.text = "Title: " + productModelObj.title
        collectionCell.lbl_ProductName.text = "Description: " + productModelObj.body_html
        collectionCell.lbl_ProductTotalInventoryAvailable.text = "Total Available Inventory: " +  String(productModelObj.variants.map({$0.inventory_quantity}).reduce(0, +))
        
        let imgUrl = URL(string: productModelObj.image.src)
        collectionCell.imgView_ProductImage.kf.setImage(with: imgUrl)
        
        return collectionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    
    
}


//MARK: WEBSERVICE EXTENSION


extension CollectionDetailsViewController
{
    func Webservice_GetAllCollections() -> Void
    {
        self.view.makeToastActivity(.center)
        
        let allCollectionsURL = ApiURL.collects
        var parameterDict = ApiParameterDict()
        parameterDict["collection_id"] = collectionID
        
        
        webserviceHelper.sharedInstance.getData(URL: allCollectionsURL, parameterDict: parameterDict, methodType: .get, headerDict:nil, Encoding:URLEncoding.default, SuccessBlock:
            {
                (responseData) in
                //Handle Success
                do
                {
                    let CollectsModelData = try JSONDecoder().decode(CollectsModel.self, from: responseData!)
                    
                    self.productIDArray = CollectsModelData.collects.map{ $0.product_id }
                    
                    print(self.productIDArray)
                    
                    DispatchQueue.main.async
                    {
                        self.Webservice_GetAllProductDetails()
                    }
                }
                catch
                {
                    print(error)
                }
                
                self.view.hideToastActivity()
        },
                                                FailureMessage:
            {
                (FailureMessage) in
                //Show Failure Message
                
                print(FailureMessage)
                
                let alert = UIAlertController(title: "Message" , message: FailureMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.view.hideToastActivity()
                
        })
    }
    
    
    
    func Webservice_GetAllProductDetails() -> Void
    {
        self.view.makeToastActivity(.center)
        
        let allCollectionsURL = ApiURL.products
        var parameterDict = ApiParameterDict()
        parameterDict["ids"] = productIDArray.map({"\($0)"}).joined(separator: ",")
        
        
        webserviceHelper.sharedInstance.getData(URL: allCollectionsURL, parameterDict: parameterDict, methodType: .get, headerDict:nil, Encoding:URLEncoding.default, SuccessBlock:
            {
                (responseData) in
                //Handle Success
                do
                {
                    let AllProductsModelData = try JSONDecoder().decode(ProductsModel.self, from: responseData!)
                    
                    //print(AllProductsModelData.products.map{$0.title})
                    
                    self.FinalProductsArray = AllProductsModelData.products
                    
                    self.tblView_CollectionDetails.reloadData()
                    
                }
                catch
                {
                    print(error)
                }
                
                self.view.hideToastActivity()
        },
                                                FailureMessage:
            {
                (FailureMessage) in
                //Show Failure Message
                
                print(FailureMessage)
                
                let alert = UIAlertController(title: "Message" , message: FailureMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.view.hideToastActivity()
                
        })
    }
}


