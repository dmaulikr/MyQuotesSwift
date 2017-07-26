//
//  DetailQuoteViewController.swift
//  My Quotes
//
//  Created by admin on 7/26/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit

class DetailQuoteViewController: UIViewController {
    
    
    
    @IBOutlet weak var myTableView: UITableView!

    @IBOutlet weak var quoteCategory: UILabel!
    
    @IBOutlet weak var quoteTimeCreated: UILabel!
    
    @IBOutlet weak var quoteContent: UITextView!
    
    @IBOutlet weak var quoteAuthorName: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnLike: UIButton!
    
    
    @IBOutlet weak var btnComment: UIButton!
    
    @IBOutlet weak var shareCount: UILabel!
    
    
    @IBOutlet weak var likeCount: UILabel!
    
    
    @IBOutlet weak var commentCount: UILabel!
    
    var loadingView: UILabel = UILabel()
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    var mCategory: String?
    var mTimeCreated: String?
    var mQuoteContent: String?
    var mAuthorName: String?
    var mQuoteId:String?
    var mQuoteShareCount: Int?
    var mQuotelikeCount: Int?
    var mQuoteCommentCount: Int?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()

    }
    
    func setUpView() -> Void {
        quoteCategory.text = mCategory
        quoteTimeCreated.text = mTimeCreated
        quoteContent.text = mQuoteContent
        quoteAuthorName.text = mAuthorName
        
        
        
        setIndicatorView()
        
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

    
    
    
    @IBAction func shareQuote(_ sender: Any) {
    }
    
    
    @IBAction func likeQuote(_ sender: Any) {
    }
    
    @IBAction func addComment(_ sender: Any) {
    }
    
   
}
