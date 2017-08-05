//
//  UpLoadQuoteToBackendlessViewController.swift
//  My Quotes
//
//  Created by admin on 6/30/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class UpLoadQuoteToBackendlessViewController: UIViewController {
    
    @IBOutlet weak var inputAuthor: UITextField!
    
    @IBOutlet weak var inputQuoteContent: UITextField!
    
    
    @IBOutlet weak var inputCategory: UITextField!
    
    
    @IBOutlet weak var btnOk: UIButton!
    
    var hvaSoftware = UILabel()
    
    
    let backendless = Backendless.sharedInstance()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    let tvLoading = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        
    
        
        
    }
    
    func setUpView() -> Void {
        inputAuthor.isSelected = false
        inputQuoteContent.isSelected = false
        inputCategory.isSelected = false
        btnOk.layer.cornerRadius = 3
        
        
    }
    func setUpHvASoftware() -> Void {
        view.addSubview(hvaSoftware)
        hvaSoftware.text = "HVA Software 2017"
        hvaSoftware.font = hvaSoftware.font.withSize(16)
        hvaSoftware.textColor = UIColor.black
        
        
        
        
        
        
   
        /*
         let left = NSLayoutConstraint(item: hvaSoftware, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
         
         let right = NSLayoutConstraint(item: hvaSoftware, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
         
         let bottom = NSLayoutConstraint(item: hvaSoftware, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
         
         
         let height = NSLayoutConstraint(item: hvaSoftware, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/10, constant: 0)
         
         
         hvaSoftware.autoresizesSubviews = false
         
         hvaSoftware.translatesAutoresizingMaskIntoConstraints = false
         
         view.addConstraints([left, right, bottom, height])

 */
        

        
        
    }
    
    
    
    
    
    
    @IBAction func uploadQuoteToSever(_ sender: Any) {
        if (inputQuoteContent.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" || inputCategory.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "" || inputCategory.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == "") {
            Toast(text: "Some value is empty").show()
            return;
            
        } else {
            
            if Reachabilities.isConnectedToNetwork(){
                print("Internet Connection Available!")
            }else{
                Toast(text: "Internet Connection not Available!").show()
                return
            }
            
            
            if (inputQuoteContent.text?.characters.count)! < 10 {
                Toast(text: "It's too short").show()
                return;
            }
            
            showActivityIndicatory()
            
            let systemVersion = UIDevice.current.systemVersion
            let model = UIDevice.current.model
            let user = ["userQuoteAuthorName": inputAuthor.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) ?? "Author",
                        "userQuoteContent": inputQuoteContent.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) ?? "Quote",
                        "userQuoteCategoryName": inputCategory.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) ?? "Category",
                        "userQuoteCategoryId": UUID().uuidString,
                        "userQuoteAuthorId": UUID().uuidString,
                        "userQuoteId": UUID().uuidString,
                        "userQuoteDevice": "\(model) - \(systemVersion)",
                "userQuoteLocation": NSLocale.current.regionCode ?? "US",
                "userQuoteCommentCount": 0,
                "userQuoteLikeCount": 0,
                "userQuoteShareCount": 0] as [String : Any]
            
            
            let dataStore = self.backendless?.data.ofTable("USER")
            dataStore?.save(user, response: { (user) in
                Toast(text: "Upload Quote Done").show()
                self.hiddenIndicatorView()
                
            }, error: { (fault) in
                Toast(text: "This quote already exists on sever \(String(describing: fault?.message))").show()
                print(fault?.message ?? "error")
                self.hiddenIndicatorView()
            })
            
        }
    }
    
    
    
    
    func showActivityIndicatory() {
        actInd.center = view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = .gray
        view.addSubview(actInd)
        actInd.startAnimating()
        
        view.addSubview(tvLoading)
        tvLoading.text = "Uploading..."
        tvLoading.textColor = UIColor.lightGray
        tvLoading.topAnchor.constraint(equalTo: actInd.bottomAnchor, constant: 5).isActive = true
        tvLoading.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tvLoading.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        tvLoading.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30).isActive = true
        tvLoading.isHidden = false
        tvLoading.textAlignment = NSTextAlignment.center
        tvLoading.font = tvLoading.font.withSize(10)
        
        tvLoading.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func hiddenIndicatorView() -> Void {
        actInd.stopAnimating()
        tvLoading.isHidden = true
        inputQuoteContent.text = ""
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
