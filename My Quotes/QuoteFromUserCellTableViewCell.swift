//
//  QuoteFromUserCellTableViewCell.swift
//  My Quotes
//
//  Created by admin on 6/30/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster
import CoreData

class QuoteFromUserCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btnFavorites: UIButton!
    
    @IBOutlet weak var quoteCategory: UILabel!
    
    
    @IBOutlet weak var quoteTimeCreated: UILabel!
    
    
    @IBOutlet weak var quoteContent: UILabel!
    
    @IBOutlet weak var quoteAuthor: UILabel!
    
    var checkFavorites: Bool = false
    var quoteId: String?
    var quoteCommentCount: Int = 0
    var quoteLikeCount: Int = 0
    var quoteShareCount: Int = 0

    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var positionCell: Int?
    
    
    

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
            let imgFavoriteOn = UIImage(named: "favorite_star_on_512.png")
            btnFavorites.setImage(imgFavoriteOn, for: .normal)
            checkFavorites = true
            if quoteCategory.text != "" && quoteContent.text != "" && quoteAuthor.text != "" {
                
                let newFavorites = NSEntityDescription.insertNewObject(forEntityName: "FAVORITES", into: context)
                newFavorites.setValue(self.quoteCategory.text, forKey: "quoteCategoryName")
                newFavorites.setValue(self.quoteTimeCreated.text, forKey: "timeAdd")
                newFavorites.setValue(self.quoteContent.text, forKey: "quoteContent")
                newFavorites.setValue(self.quoteAuthor.text, forKey: "quoteAuthorName")
                newFavorites.setValue(self.quoteId, forKey: "objectId")
                newFavorites.setValue(self.quoteCommentCount, forKey: "quoteCommentCount")
                newFavorites.setValue(self.quoteLikeCount, forKey: "quoteLikeCount")
                newFavorites.setValue(self.quoteShareCount, forKey: "quoteShareCount")

                
                
                
                
                
                Toast(text: "Add to favorites").show()
                
                print("POSITION CELL \(String(describing: positionCell))======================")

                print(positionCell ?? "null cmnr")
                
                
                
                
                do{
                    try context.save()
                    
                }catch{
                    print(error)
                }

                
                
                
                
                
   
                /*
                 var quoteCategoryName: String?
                 var quoteId: String?
                 var quoteContent: String?
                 var quoteAuthorName: String?
                 var quoteAuthorId: String?
                 var quoteCategoryId: String?
                 var quoteImage: String?
                 var created: NSDate?
                 var objectId: String?
                 var quoteCommentCount: Int = 0
                 var quoteLikeCount: Int = 0
                 var quoteShareCount: Int = 0
 */
                
                
                
                
                
                
                
            }else{
                Toast(text: "No Data").show()
            }
            
            
            
            
            

            
        }else{
            let imgFavoriteOn = UIImage(named: "favorite_star_off_512.png")
            btnFavorites.setImage(imgFavoriteOn, for: .normal)
            checkFavorites = false
            
            
            
        }
 
        
        
        
        
        
    }
    
  
    
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        


        // Configure the view for the selected state
    }

}
