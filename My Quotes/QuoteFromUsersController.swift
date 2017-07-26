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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        setIndicatorView()
        
        getAllQuoteFroUserWithDataqueryBuilder()
        
    }
    
    func setUpTableView() -> Void {
        myTableview.delegate = self
        myTableview.dataSource = self
        myTableview.separatorColor = UIColor.black
        myTableview.separatorStyle = UITableViewCellSeparatorStyle.none
        
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
            // Toast(text: "Load Done").show()
            self.indicatorView.stopAnimating()
            self.loadingView.isHidden = true
        },error: {(fault : Fault?) -> () in
            Toast(text: "Load Error").show()
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //getAllQuoteFroUserWithDataqueryBuilder()
        
        print("VIEW DIDAPPEAR")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("VIEW WILL APPEAR")
        
    }
    
    
    
    func getAllQuoteFromUser() -> Void {
        let dataStore = self.backendless?.data.of(USER().ofClass())
        
        dataStore?.find({
            (array) -> () in
            self.mQuoteListFromUser = array as! [USER]
            self.myTableview.reloadData()
            
            
            print("Result Class: \(self.mQuoteListFromUser)")
        }, error: { (fault : Fault?) -> () in
            print("Server reported an error: \(String(describing: fault))")
        })
    }
    
    
    func getAllQuoteFromUser1() -> Void {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setPageSize(25).setOffset(0)
        let dataStore = backendless?.data.ofTable("USER")
        dataStore?.find(queryBuilder, response: {
            (result) -> () in
            
            //mQuoteListFromUser = result as! [[String : Any]]
            
        },error: {(fault : Fault?) -> () in
            print("Server reported an error: \(String(describing: fault))")
        })
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.quoteCategory.text = mQuoteListFromUser[indexPath.row].userQuoteCategoryName
        cell.quoteTimeCreated.text = dateString
        cell.quoteContent.text = mQuoteListFromUser[indexPath.row].userQuoteContent
        cell.quoteAuthor.text = mQuoteListFromUser[indexPath.row].userQuoteAuthorName
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.myTableview.indexPathForSelectedRow
        let detailQuote = segue.destination as! DetailQuoteViewController
        
        let date = mQuoteListFromUser[(indexPath?.row)!].created
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date!)
        
        detailQuote.mCategory = mQuoteListFromUser[(indexPath?.row)!].userQuoteCategoryName
        detailQuote.mTimeCreated = dateString
        detailQuote.mQuoteContent =  mQuoteListFromUser[(indexPath?.row)!].userQuoteContent
        detailQuote.mAuthorName =  mQuoteListFromUser[(indexPath?.row)!].userQuoteAuthorName
        detailQuote.mQuoteId = mQuoteListFromUser[(indexPath?.row)!].userQuoteId
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

