//
//  CollectionListViewController.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-10.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class CollectionListViewController: UIViewController {
    
    
    //MARK: VARIABLES
    
    var modelArray_CollectionList = [allCollections]()
    
    //MARK: OUTLETS
    
    @IBOutlet weak var tblView_CollectionList: UITableView!
    
    
    //MARK: VIEW METHODS
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tblView_CollectionList.delegate = self
        self.tblView_CollectionList.dataSource = self
        
        tblView_CollectionList.estimatedRowHeight = 100
        tblView_CollectionList.rowHeight = UITableView.automaticDimension
        
        DispatchQueue.main.async {
            
            self.Webservice_GetAllCollections()
        }
    }
    
    
    
    //MARK: IBACTIONS
    
    
    
    
    //MARK: METHODS
    
    
}



//MARK: TABLEVIEW DELEGATE & DATASOURCE METHODS

extension CollectionListViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return modelArray_CollectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let collectionCell = tblView_CollectionList.dequeueReusableCell(withIdentifier: "collection", for: indexPath)as! CollectionCell
        
        let collectionModalObject = modelArray_CollectionList[indexPath.row]
        
        collectionCell.lbl_CollectionTitle.text = "Collection Name: " + collectionModalObject.title
        collectionCell.lbl_CollectionDetails.text = "Description: " + collectionModalObject.body_html
        
        return collectionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let collectionModalObject = modelArray_CollectionList[indexPath.row]
        
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let CollectionDetailsViewController = storyboard.instantiateViewController(withIdentifier: "CollectionDetailsViewController") as! CollectionDetailsViewController
        
        CollectionDetailsViewController.collectionID = collectionModalObject.id
        
        self.navigationController?.pushViewController(CollectionDetailsViewController, animated: true)
        
    }
    
    
}


//MARK: WEBSERVICE EXTENSION


extension CollectionListViewController
{
    func Webservice_GetAllCollections() -> Void
    {
        self.view.makeToastActivity(.center)
        
        let allCollectionsURL = ApiURL.allCollection
        let parameterDict = ApiParameterDict()
        
        
        webserviceHelper.sharedInstance.getData(URL: allCollectionsURL, parameterDict: parameterDict, methodType: .get, headerDict:nil, Encoding:URLEncoding.default, SuccessBlock:
            {
                (responseData) in
                //Handle Success
                do
                {
                    let allBookingsData = try JSONDecoder().decode(AllCollectionsModel.self, from: responseData!)
                    
                    print(allBookingsData.custom_collections.first?.id)
                    
                    print(allBookingsData.custom_collections.count)
                    
                    self.modelArray_CollectionList = allBookingsData.custom_collections
                    
                    self.tblView_CollectionList.reloadData()
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
