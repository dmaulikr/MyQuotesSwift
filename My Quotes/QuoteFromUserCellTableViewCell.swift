//
//  QuoteFromUserCellTableViewCell.swift
//  My Quotes
//
//  Created by admin on 6/30/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit

class QuoteFromUserCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btnFavorites: UIButton!
    
    @IBOutlet weak var quoteCategory: UILabel!
    
    
    @IBOutlet weak var quoteTimeCreated: UILabel!
    
    
    @IBOutlet weak var quoteContent: UILabel!
    
    @IBOutlet weak var quoteAuthor: UILabel!
    
    var checkFavorites: Bool = false
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        if checkFavorites {
            let imgFavoriteOn = UIImage(named: "favorite_star_on_512.png")
            btnFavorites.setImage(imgFavoriteOn, for: .normal)
            

        }else{
            let imgFavoriteOn = UIImage(named: "favorite_star_off_512.png")
            btnFavorites.setImage(imgFavoriteOn, for: .normal)

        }
        
        
    }
    
    
    @IBAction func setFavorites(_ sender: Any) {
        
        if !checkFavorites {
            let imgFavoriteOn = UIImage(named: "favorite_star_off_512.png")
            btnFavorites.setImage(imgFavoriteOn, for: .normal)
            checkFavorites = true
            
            
        }else{
            let imgFavoriteOn = UIImage(named: "favorite_star_on_512.png")
            btnFavorites.setImage(imgFavoriteOn, for: .normal)
            checkFavorites = false
            
        }
 
        
        
        
        
        
    }
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
