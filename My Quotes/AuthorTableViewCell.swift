//
//  AuthorTableViewCell.swift
//  My Quotes
//
//  Created by Hoàng Vũ Anh on 8/4/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgAuthor: UIImageView!
    
    
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var authorBirthday: UILabel!
    
    
    @IBOutlet weak var authorCountry: UILabel!
    
    
    @IBOutlet weak var authorBiography: UITextView!
    
    
    @IBOutlet weak var btnLike: UIButton!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    
    @IBOutlet weak var btnInfo: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func likeAuthor(_ sender: Any) {
    }
    
    @IBAction func shareAuthor(_ sender: Any) {
    }
    
    
    @IBAction func showInforAuthor(_ sender: Any) {
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
