//
//  AddCommentViewController.swift
//  My Quotes
//
//  Created by admin on 7/27/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

class AddCommentViewController: UIViewController {
    
    @IBOutlet weak var txfInputUsername: UITextField!
    
    @IBOutlet weak var txfInputCommentContent: UITextField!
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    let tvLoading = UILabel()

    @IBOutlet weak var btnOk: UIButton!
    
    let backendless = Backendless.sharedInstance()

    
    var cmQuoteId: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnOk.layer.cornerRadius = 3
        
       
        
        
        

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
        txfInputCommentContent.text = ""
    }

    
    
    
    @IBAction func upLoadComment(_ sender: Any) {
        if((txfInputUsername.text?.isEmpty)! || (txfInputCommentContent.text?.isEmpty)!){
            Toast(text: "Empty Value").show()
            return
        }
        showActivityIndicatory()
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.model
        let comment = ["cmAuthor": txfInputUsername.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) ?? "Author",
                    "cmContent": txfInputCommentContent.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) ?? "Great",
                    "cmLocation": NSLocale.current.regionCode ?? "US",
                    "cmDevice": "\(systemVersion) - \(model)",
                    "cmQuoteId": cmQuoteId ?? "QuoteId"] as [String : Any]
        
        
        let dataStore = self.backendless?.data.ofTable("COMMENT")
        dataStore?.save(comment, response: { (comment) in
            Toast(text: "Upload Comment Done").show()
            self.hiddenIndicatorView()
            
            
        }, error: { (fault) in
            Toast(text: "This quote already exists on sever \(String(describing: fault?.message))").show()
            print(fault?.message ?? "error")
            
            //self.hiddenIndicatorView()
        })

        


}
}
