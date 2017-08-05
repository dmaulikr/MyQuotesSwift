//
//  ViewController.swift
//  My Quotes
//
//  Created by admin on 6/18/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class QuoteFromUsersController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var myTableview: UITableView!
    
    var loadingView: UILabel = UILabel()
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var valueToPass:String!
    var positon: Int?
    
    
    let backendless = Backendless.sharedInstance()
    var mQuoteListFromUser: [USER] = []
    
    var isRead:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        
        
        setIndicatorView()
        
        
        
        getAllQuoteFroUserWithDataqueryBuilder()
        
        
        
    }
    
    func setUpTableView() -> Void {
        myTableview.delegate = self
        myTableview.dataSource = self
        myTableview.estimatedRowHeight = 100
        myTableview.rowHeight = UITableViewAutomaticDimension
        
    }
    
    
    func setLoadingText() -> Void {
        view.addSubview(loadingView)
        loadingView.text = "Loading"
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        loadingView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 1/30).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        loadingView.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: 5).isActive = true
        loadingView.textAlignment = NSTextAlignment.center
        loadingView.font = loadingView.font.withSize(10)
        loadingView.textColor = UIColor.lightGray
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setIndicatorView() -> Void {
        indicatorView.center = self.view.center
        indicatorView.hidesWhenStopped = true
        loadingView.isHidden = false
        indicatorView.isHidden = false
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        setLoadingText()
    }
    
    func getAllQuoteFroUserWithDataqueryBuilder() -> Void {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setSortBy(["created DESC"])
        let dataStore = self.backendless?.data.of(USER().ofClass())
        dataStore?.find(queryBuilder, response: { (sorted) -> () in
            self.mQuoteListFromUser = sorted as! [USER]
            self.myTableview.reloadData()
            self.loadingFinish()
        },error: {(fault : Fault?) -> () in
            Toast(text: "Load Error").show()
        })
    }
    
    
    func loadingFinish() -> Void {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        loadingView.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mQuoteListFromUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuoteFromUserCellTableViewCell
        
        let date = mQuoteListFromUser[indexPath.row].created
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date!)
        
        cell.positionCell = indexPath.row
        cell.quoteCategory.text = mQuoteListFromUser[indexPath.row].userQuoteCategoryName
        cell.quoteTimeCreated.text = dateString
        cell.quoteContent.text = mQuoteListFromUser[indexPath.row].userQuoteContent
        cell.quoteAuthor.text = mQuoteListFromUser[indexPath.row].userQuoteAuthorName
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailQuoteViewController = storyBoard.instantiateViewController(withIdentifier: "DetailQuoteViewController") as! DetailQuoteViewController
        let date = mQuoteListFromUser[indexPath.row].created
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date!)
        detailQuoteViewController.mCategory = mQuoteListFromUser[indexPath.row].userQuoteCategoryName
        detailQuoteViewController.mTimeCreated = dateString
        detailQuoteViewController.mQuoteContent =  mQuoteListFromUser[indexPath.row].userQuoteContent
        detailQuoteViewController.mAuthorName =  mQuoteListFromUser[indexPath.row].userQuoteAuthorName
        detailQuoteViewController.cmQuoteId = mQuoteListFromUser[indexPath.row].objectId
        detailQuoteViewController.mQuoteShareCount = mQuoteListFromUser[indexPath.row].userQuoteShareCount
        detailQuoteViewController.mQuotelikeCount = mQuoteListFromUser[indexPath.row].userQuoteLikeCount
        self.navigationController?.pushViewController(detailQuoteViewController, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

