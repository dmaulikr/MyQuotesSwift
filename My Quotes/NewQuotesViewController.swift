//
//  NewQuotesViewController.swift
//  My Quotes
//
//  Created by admin on 7/20/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster
import CoreData

class NewQuotesViewController: UIViewController {
    
    let buttonRandom = UIButton()
    let buttonFavorite = UIButton()
    let quoteCategory = UILabel()
    let quoteTimeCreated = UILabel()
    let quoteContent = UITextView()
    let quoteAuthor = UILabel()
    let sizeofbutton = 22
    var isFavorite:Bool = false
    var mListQuote: [QUOTE] = []
    let backendless = Backendless.sharedInstance()
    var tapTerm: UITapGestureRecognizer = UITapGestureRecognizer()
    
    var loadingView: UILabel = UILabel()
    var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var quoteId: String?
    var quoteCommentCount: Int = 0
    var quoteLikeCount: Int = 0
    var quoteShareCount: Int = 0
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var created: Date?
    
    var checkLoad: Bool = false
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        
        setUpView()
        
        
        getNewQuoteFromSever()
        
        
        setUpQuoteContent()
        
        
        setUpQuoteTimeCreated()
        
        
        setUpQuoteCategory()
        
        
        
        setUpQuoteAuthor()
        
        
        
        setUpButtonRandomQuote()
        
        
        
        
        setUpButtonFavorites()
        
        
        
        
        setActionForButton()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if !checkLoad {
            showLoadingView()
        }else{
            loadingFinish()
        }
    }
    
    
    
    
    func showLoadingView() -> Void {
        
        
        print("SHOW LOADING VIEW ============================")
        
        
        indicatorView.center = self.view.center
        indicatorView.hidesWhenStopped = true
        loadingView.isHidden = false
        indicatorView.isHidden = false
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        
        
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
    
  
    func loadingFinish() -> Void {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        loadingView.isHidden = true
    }
    
    
    func setUpView() -> Void {
        buttonFavorite.isHidden = true
        buttonRandom.isHidden = true
        tapTerm = UITapGestureRecognizer(target: self, action: Selector(("tapTextView:")))
        quoteContent.delegate = self as? UITextViewDelegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(quoteContentClicked))
        tap.numberOfTapsRequired = 1
        quoteContent.addGestureRecognizer(tap)
    }
    
    func quoteContentClicked(recognizer: UITapGestureRecognizer) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailQuoteViewController = storyBoard.instantiateViewController(withIdentifier: "DetailQuoteViewController") as! DetailQuoteViewController
       
        detailQuoteViewController.mCategory = quoteCategory.text
        detailQuoteViewController.mTimeCreated = quoteTimeCreated.text
        detailQuoteViewController.mQuoteContent =  quoteContent.text
        detailQuoteViewController.mAuthorName = quoteAuthor.text
        detailQuoteViewController.cmQuoteId = quoteId
        
        detailQuoteViewController.mQuoteShareCount = quoteShareCount
        detailQuoteViewController.mQuotelikeCount = quoteLikeCount
        self.navigationController?.pushViewController(detailQuoteViewController, animated: true)
        
    }
    
    
    
    
    
    func getNewQuoteFromSever() -> Void {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setSortBy(["created DESC"])
        let dataStore = self.backendless?.data.of(QUOTE().ofClass())
        dataStore?.find(queryBuilder, response: { (sorted) -> () in
            self.mListQuote = sorted as! [QUOTE]
            self.setAllContent()
            self.loadingFinish()
            self.checkLoad = true
            
        },error: {(fault : Fault?) -> () in
            Toast(text: "Load Error").show()
            
        })
    }
    
    func setActionForButton() -> Void {
        buttonRandom.addTarget(self, action: #selector(NewQuotesViewController.buttonClicked(_:)), for: .touchUpInside)
        buttonFavorite.addTarget(self, action: #selector(NewQuotesViewController.buttonClicked(_:)), for: .touchUpInside)
        
    }
    
    
    func buttonClicked(_ sender: AnyObject?) {
        if sender === buttonRandom {
            setButtonClicked()
            
            setAllContent()
            
            
        }else{
            if !isFavorite {
                let imgFavoriteOn = UIImage(named: "favorite_star_on_512.png")
                buttonFavorite.setImage(imgFavoriteOn, for: .normal)
                isFavorite = true
                
                
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
                
                do{
                    try context.save()
                    
                }catch{
                    print(error)
                }


                
            }else{
                let imgFavoriteOn = UIImage(named: "favorite_star_off_512.png")
                buttonFavorite.setImage(imgFavoriteOn, for: .normal)
                isFavorite = false
            }
            
            
        }
    }
    
    func setButtonClicked() -> Void {
        let imgFavoriteOn = UIImage(named: "favorite_star_off_512.png")
        buttonFavorite.setImage(imgFavoriteOn, for: .normal)
        isFavorite = false
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.buttonRandom.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.buttonRandom.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }, completion: nil)
        
    }
    
    
    func setAllContent() -> Void {
        buttonRandom.isHidden = false
        buttonFavorite.isHidden = false
        let randomNum:UInt32 = arc4random_uniform(UInt32(10))
        let index:Int = Int(randomNum)
        
        quoteCategory.text = mListQuote[index].quoteCategoryName
        let date = mListQuote[index].created
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:date! as Date)
        quoteTimeCreated.text = dateString
        created = mListQuote[index].created as Date?
        quoteContent.text = mListQuote[index].quoteContent
        quoteContent.font = quoteContent.font?.withSize(18)
        quoteAuthor.text = mListQuote[index].quoteAuthorName
        quoteId = mListQuote[index].objectId
        quoteShareCount = mListQuote[index].quoteShareCount
        quoteLikeCount = mListQuote[index].quoteLikeCount
        
    }
    
    
    func setUpButtonFavorites() -> Void {
        view.addSubview(buttonFavorite)
        let imgFavoriteOn = UIImage(named: "favorite_star_off_512.png")
        buttonFavorite.setImage(imgFavoriteOn, for: .normal)
        buttonFavorite.rightAnchor.constraint(equalTo: buttonRandom.leftAnchor, constant: -10).isActive = true
        buttonFavorite.widthAnchor.constraint(equalToConstant: CGFloat(sizeofbutton)).isActive = true
        buttonFavorite.heightAnchor.constraint(equalToConstant: CGFloat(sizeofbutton)).isActive = true
        buttonFavorite.bottomAnchor.constraint(equalTo: quoteCategory.topAnchor, constant: -20).isActive = true
        buttonFavorite.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpButtonRandomQuote() -> Void {
        
        view.addSubview(buttonRandom)
        let imgFavoriteOn = UIImage(named: "refresh_button")
        buttonRandom.setImage(imgFavoriteOn, for: .normal)
        buttonRandom.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        buttonRandom.widthAnchor.constraint(equalToConstant: CGFloat(sizeofbutton)).isActive = true
        buttonRandom.heightAnchor.constraint(equalToConstant: CGFloat(sizeofbutton)).isActive = true
        buttonRandom.bottomAnchor.constraint(equalTo: quoteCategory.topAnchor, constant: -20).isActive = true
        buttonRandom.translatesAutoresizingMaskIntoConstraints = false;
        
    }
    
    
    func setUpQuoteAuthor() -> Void {
        quoteAuthor.textColor = #colorLiteral(red: 0.5058823529, green: 0.7803921569, blue: 0.5176470588, alpha: 1)
        quoteAuthor.textAlignment = NSTextAlignment.right
        quoteAuthor.font = quoteAuthor.font.withSize(14)
        view.addSubview(quoteAuthor)
        quoteAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteAuthor.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteAuthor.heightAnchor.constraint(equalToConstant: 18).isActive = true
        quoteAuthor.topAnchor.constraint(equalTo: quoteContent.bottomAnchor, constant: 1).isActive = true
        quoteAuthor.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    func setUpQuoteCategory() -> Void {
        quoteCategory.textColor = #colorLiteral(red: 0.9333333333, green: 0.5882352941, blue: 0.5725490196, alpha: 1)
        quoteCategory.font = quoteCategory.font.withSize(14)
        quoteCategory.textAlignment = NSTextAlignment.center
        view.addSubview(quoteCategory)
        quoteCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteCategory.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteCategory.heightAnchor.constraint(equalToConstant: 18).isActive = true
        quoteCategory.bottomAnchor.constraint(equalTo: quoteTimeCreated.topAnchor, constant: 1).isActive = true
        quoteCategory.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func setUpQuoteTimeCreated() -> Void {
        quoteTimeCreated.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        quoteTimeCreated.font = quoteTimeCreated.font.withSize(10)
        quoteTimeCreated.textAlignment = NSTextAlignment.center
        view.addSubview(quoteTimeCreated)
        quoteTimeCreated.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteTimeCreated.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteTimeCreated.heightAnchor.constraint(equalToConstant: 12).isActive = true
        quoteTimeCreated.bottomAnchor.constraint(equalTo: quoteContent.topAnchor, constant: -8).isActive = true
        quoteTimeCreated.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 1).isActive = true
        quoteTimeCreated.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
    
    
    
    func setUpQuoteContent() -> Void {
        quoteContent.backgroundColor = UIColor.white
        quoteContent.textColor = UIColor.black
        quoteContent.isEditable = false
        quoteContent.isSelectable = false
        quoteContent.delegate = self as? UITextViewDelegate
        view.addSubview(quoteContent)
        quoteContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteContent.heightAnchor.constraint(equalToConstant: 100).isActive = true
        quoteContent.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        quoteContent.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    
    
    @IBAction func searchContent(_ sender: Any) {
        let alert = UIAlertController(title: "Seacrh", message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Search Category", style: .default, handler: { (action) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let searchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            searchViewController.searchId = "CATEGORY"
            self.navigationController?.pushViewController(searchViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Search Quote", style: .default, handler: { (action) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let searchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            searchViewController.searchId = "QUOTE"
            self.navigationController?.pushViewController(searchViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Search Auhthor", style: .default, handler: { (action) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let searchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            searchViewController.searchId = "AUTHOR"
            self.navigationController?.pushViewController(searchViewController, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil ))
        self.present(alert, animated: true, completion: nil)
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
