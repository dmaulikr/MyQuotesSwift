//
//  DetailQuoteViewController.swift
//  My Quotes
//
//  Created by admin on 7/26/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class DetailQuoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cmAuthorName: UITextView = UITextView()
    var cmContent: UITextView = UITextView()
    
    var lblCmAuthor: UILabel = UILabel()
    var lblCmContent: UILabel = UILabel()
    var isLike: Bool = false
    var lblNoComment: UILabel = UILabel()
    
    
    
    
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
    
    var mCommentList: [COMMENT] = []
    
    let comment = COMMENT()
    let user = USER()
    
    let backendless = Backendless.sharedInstance()
    
    
    
    
    var loadingView: UILabel = UILabel()
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    var mCategory: String?
    var mTimeCreated: String?
    var mQuoteContent: String?
    var mAuthorName: String?
    var cmQuoteId:String!
    
    var mQuoteShareCount: Int?
    var mQuotelikeCount: Int?
    var mQuoteCommentCount: Int?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpView()
        
        
        setUpCommentContent()
        
        
        
    }
    
    
    
    func setUpLabel() -> Void {
        view.addSubview(lblNoComment)
        lblNoComment.text = "No Comment! Click button comment to add comment"
        lblNoComment.font = lblNoComment.font.withSize(10)
        lblNoComment.textAlignment = NSTextAlignment.center
        lblNoComment.centerXAnchor.constraint(equalTo: myTableView.centerXAnchor, constant: 1).isActive = true
        lblNoComment.centerYAnchor.constraint(equalTo: myTableView.centerYAnchor, constant: 1).isActive = true
        lblNoComment.heightAnchor.constraint(equalTo: myTableView.heightAnchor, multiplier: 1/2).isActive = true
        lblNoComment.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        lblNoComment.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setUpCommentContent() -> Void {
        cmAuthorName.textColor = UIColor.black
        cmContent.textColor = UIColor.lightGray
        lblCmAuthor.textColor = UIColor.black
        lblCmContent.textColor = UIColor.lightGray
        view.addSubview(lblCmAuthor)
        view.addSubview(lblCmContent)
        view.addSubview(cmAuthorName)
        view.addSubview(cmContent)
    }
    
    func setUpView() -> Void {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        quoteCategory.text = mCategory
        quoteTimeCreated.text = mTimeCreated
        quoteContent.text = mQuoteContent
        quoteAuthorName.text = mAuthorName
        
       // myTableView.estimatedRowHeight = 100
       // myTableView.rowHeight = UITableViewAutomaticDimension

        
        
        
        let stringShareCount = String(describing: mQuoteShareCount!)
        let stringLikeCount = String(describing: mQuotelikeCount!)
        
        shareCount.text = stringShareCount
        likeCount.text = stringLikeCount
        setIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getCommentByQuoteId()
        
    }
    
    func getCommentByQuoteId() -> Void {
        let cmdId:String = cmQuoteId ?? ""
        
        let whereClause = "cmQuoteId = '\(cmdId)'"
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setSortBy(["created DESC"])
        queryBuilder!.setWhereClause(whereClause)
        
        let dataStore = self.backendless?.data.of(COMMENT().ofClass())
        dataStore?.find(queryBuilder,
                        response: {
                            (foundContacts) -> () in
                            self.mCommentList = foundContacts as! [COMMENT]
                            self.myTableView.reloadData()
                            self.indicatorView.stopAnimating()
                            self.loadingView.isHidden = true
                            if self.mCommentList.count == 0 {
                                self.commentCount.text = "0"
                                self.setUpLabel()
                                self.myTableView.isHidden = true
                            }else{
                                let stringCommentCount = String(describing: self.mCommentList.count)
                                self.commentCount.text = stringCommentCount
                                let user = ["objectId": self.cmQuoteId, "userQuoteCommentCount": self.mCommentList.count] as [String : Any]
                                let dataStore = self.backendless?.data.ofTable("USER")
                                dataStore?.save(user, response: { (user) in
                                    print("SET COMMENT COUNT DONE")
                                    
                                    
                                }, error: { (fault) in
                                    print(fault?.message ?? "error")
                                })
                                
                            }
        }, error: { (fault : Fault?) -> () in
            print("Server reported an error: \(String(describing: fault))")
        })
        
        
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mCommentList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentTableViewCell
        cell.lblCmAuthor.text = mCommentList[indexPath.row].cmAuthor
        cell.lblCmContent.text = mCommentList[indexPath.row].cmContent
        return cell
    }
    
    
    
    
    @IBAction func shareQuote(_ sender: Any) {
        let stringShareCount = String(describing: mQuoteShareCount! + 1)
        let text = mQuoteContent
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: [textToShare as Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
        let user = ["objectId": cmQuoteId, "userQuoteShareCount": mQuoteShareCount! + 1 ] as [String : Any]
        let dataStore = self.backendless?.data.ofTable("USER")
        dataStore?.save(user, response: { (user) in
            Toast(text: "Share").show()
            self.shareCount.text = stringShareCount
        }, error: { (fault) in
            print(fault?.message ?? "error")
        })
    }
    
    @IBAction func likeQuote(_ sender: Any) {
        if !isLike {
            isLike = true
            let stringLikeCount = String(describing: mQuotelikeCount! + 1)
            let image = UIImage(named: "ic_like_on_36pt")
            btnLike.setImage(image, for: .normal)
            let user = ["objectId": cmQuoteId, "userQuoteLikeCount": mQuotelikeCount! + 1 ] as [String : Any]
            let dataStore = self.backendless?.data.ofTable("USER")
            dataStore?.save(user, response: { (user) in
                self.likeCount.text = stringLikeCount
                Toast(text: "Liked").show()
            }, error: { (fault) in
                print(fault?.message ?? "error")
            })
            
        }else{
            Toast(text: "You already liked this quote").show()
        }
    }
    
    @IBAction func addComment(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addComment = storyBoard.instantiateViewController(withIdentifier: "AddComment") as! AddCommentViewController
        addComment.cmQuoteId = cmQuoteId
        self.navigationController?.pushViewController(addComment, animated: true)
    }
}
