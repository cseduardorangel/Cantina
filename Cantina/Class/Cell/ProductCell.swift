//
//  ProductCell.swift
//  Cantina
//
//  Created by Eduardo Rangel on 8/26/15.
//  Copyright © 2015 Concrete Solutions. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}