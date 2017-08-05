//
//  FavoritesViewController.swift
//  My Quotes
//
//  Created by Hoàng Vũ Anh on 8/3/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    var favoriteList:[FAVORITES] = []
    
    var lblNoFavorite = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        
        setUpLabel()
        
        
        

    }
    
    func setUpLabel() -> Void {
        view.addSubview(lblNoFavorite)
        lblNoFavorite.text = "No Favorite!"
        lblNoFavorite.font = lblNoFavorite.font.withSize(18)
        lblNoFavorite.textColor = UIColor.lightGray
        
        lblNoFavorite.textAlignment = NSTextAlignment.center
        
        lblNoFavorite.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        lblNoFavorite.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        
        lblNoFavorite.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 1).isActive = true
        lblNoFavorite.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true

        lblNoFavorite.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpTableView() -> Void {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.estimatedRowHeight = 100
        myTableView.rowHeight = UITableViewAutomaticDimension
           
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchData()
        
        myTableView.reloadData()

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.lblCategory.text = favoriteList[indexPath.row].quoteCategoryName
        
       if (favoriteList[indexPath.row].timeAdd?.isEmpty)! {
            cell.lblTime.text = "No Data"
        }else{
            cell.lblTime.text = favoriteList[indexPath.row].timeAdd
       }
        
        
        cell.lblQuoteContent.text = favoriteList[indexPath.row].quoteContent
        cell.lblAuthor.text = favoriteList[indexPath.row].quoteAuthorName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let user = favoriteList[indexPath.row]
            context.delete(user)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                favoriteList = try context.fetch(FAVORITES.fetchRequest())
                Toast(text: "Remove to favorite").show()
                
            }catch{
                print(error)
            }
            
        }
        tableView.reloadData()
        

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailQuoteViewController = storyBoard.instantiateViewController(withIdentifier: "DetailQuoteViewController") as! DetailQuoteViewController
        
        detailQuoteViewController.mCategory = favoriteList[indexPath.row].quoteCategoryName
        detailQuoteViewController.mTimeCreated = favoriteList[indexPath.row].timeAdd
        detailQuoteViewController.mQuoteContent =  favoriteList[indexPath.row].quoteContent
        detailQuoteViewController.mAuthorName =  favoriteList[indexPath.row].quoteAuthorName
        detailQuoteViewController.cmQuoteId = favoriteList[indexPath.row].objectId
        
        detailQuoteViewController.mQuotelikeCount = 0
        
        
        detailQuoteViewController.mQuoteShareCount = 0
        
       
        self.navigationController?.pushViewController(detailQuoteViewController, animated: true)
        
        
        
        
        
    }
    
    
    
    func fetchData() -> Void {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            favoriteList = try context.fetch(FAVORITES.fetchRequest())
            if favoriteList.count == 0 {
                myTableView.isHidden = true
                lblNoFavorite.isHidden = false
            }else{
                myTableView.isHidden = false
                lblNoFavorite.isHidden = true
            }
        }catch{
            print(error)
        }
    }

    

}
