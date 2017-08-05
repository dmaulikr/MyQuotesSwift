//
//  FavoriteTableViewCell.swift
//  My Quotes
//
//  Created by Hoàng Vũ Anh on 8/3/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    
    
    
    
    @IBOutlet weak var lblCategory: UILabel!
    
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblQuoteContent: UILabel!
    
    @IBOutlet weak var lblAuthor: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
      

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
