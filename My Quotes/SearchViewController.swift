//
//  SearchViewController.swift
//  My Quotes
//
//  Created by admin on 8/1/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var txfSearchContent: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var btnSeacrh: UIButton!
    
    var mListQuote: [QUOTE] = []
    let backendless = Backendless.sharedInstance()
    
    var searchId: String?
    
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var loadingView: UILabel = UILabel()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSeacrh.layer.cornerRadius = 3
        print("======================\(String(describing: searchId))")
        
        
    }
    
    func showLoadingView() -> Void {
        indicatorView.center = self.view.center
        indicatorView.hidesWhenStopped = true
        indicatorView.isHidden = false
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        view.addSubview(loadingView)
        loadingView.text = "Loading"
        loadingView.isHidden = false
        
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
    
    func setLoadingText() -> Void {
        view.addSubview(loadingView)
        loadingView.text = "Loading"
        loadingView.isHidden = false
        
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
        indicatorView.isHidden = false
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        setLoadingText()
        
    }
    
    
    
    func stopLoading() -> Void {
        indicatorView.isHidden = true
        loadingView.isHidden = true
    }
    
    
    
    @IBAction func searchQuote(_ sender: Any) {
        showLoadingView()
        if txfSearchContent.text == "" {
            Toast(text: "Empty! Please input content to search").show()
            stopLoading()
        }else{
            getQuoteFromContentSearch(contentSearch: txfSearchContent.text!)
        }
    }
    
    func getQuoteFromContentSearch(contentSearch: String) -> Void {
        let whereClause = "quoteContent LIKE '%\(contentSearch)%'"
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause(whereClause)
        
        let dataStore = self.backendless?.data.of(QUOTE().ofClass())
        dataStore?.find(queryBuilder,
                        response: {
                            (foundContacts) -> () in
                            self.mListQuote = foundContacts as! [QUOTE]
                            if self.mListQuote.count == 0{
                                Toast(text: "No Data").show()
                            }
                            self.myTableView.reloadData()
                            self.stopLoading()
                            
        },
                        error: {
                            (fault : Fault?) -> () in
                            print("Server reported an error: \(String(describing: fault))")
        })
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mListQuote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        
        cell.lblCategory.text = mListQuote[indexPath.row].quoteCategoryName
        
        cell.lblTime.text = "time"
        cell.lblQuoteContent.text = mListQuote[indexPath.row].quoteContent
        cell.lblAuthor.text = mListQuote[indexPath.row].quoteAuthorName
        
        
        
        
        return cell
    }
    
    
}
