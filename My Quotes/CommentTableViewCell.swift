//
//  CommentTableViewCell.swift
//  My Quotes
//
//  Created by admin on 8/1/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblCmContent: UILabel!
    
    @IBOutlet weak var lblCmAuthor: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
