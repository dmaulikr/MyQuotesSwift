//
//  SearchTableViewCell.swift
//  My Quotes
//
//  Created by admin on 8/1/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btnFavorites: UIButton!
    
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
    @IBAction func setFavorites(_ sender: Any) {
    }

}
