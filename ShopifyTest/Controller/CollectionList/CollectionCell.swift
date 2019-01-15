//
//  CollectionCell.swift
//  ShopifyTest
//
//  Created by Kalpesh Thakare on 2019-01-11.
//  Copyright © 2019 Kalpesh Thakare. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

    
    @IBOutlet weak var lbl_CollectionTitle: UILabel!
    
    @IBOutlet weak var lbl_CollectionDetails: UILabel!
    
    @IBOutlet weak var view_Main: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
