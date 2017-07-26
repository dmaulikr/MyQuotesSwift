//
//  NewQuotesViewController.swift
//  My Quotes
//
//  Created by admin on 7/20/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

import UIKit
import Toaster

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpQuoteContent()
        
        
        setUpQuoteTimeCreated()
        
        
        setUpQuoteCategory()
        
        
        setUpQuoteAuthor()
        
        
        setUpButtonRandomQuote()
        
        
        setUpButtonFavorites()
        
        
        setAllContent()
        
        
        setActionForButton()
        
        
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
        quoteCategory.text = "Sports"
        quoteTimeCreated.text = "20 June 2017"
        quoteContent.text = "Sport allows us to engage in dialogue and to build bridges, and it may even have the capacity to reshape international relations. The Olympic Games embody perfectly this universal mission."
        quoteContent.font = quoteContent.font?.withSize(18)
        quoteAuthor.text = "Richard Attias"

        
        
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
        quoteAuthor.backgroundColor = UIColor.green
        quoteAuthor.textAlignment = NSTextAlignment.right
        quoteAuthor.font = UIFont(name: "Roboto-Light", size: 29)
      // quoteAuthor.font = quoteAuthor.font.withSize(16)
        view.addSubview(quoteAuthor)
        quoteAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteAuthor.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteAuthor.heightAnchor.constraint(equalToConstant: 18).isActive = true
        quoteAuthor.topAnchor.constraint(equalTo: quoteContent.bottomAnchor, constant: 1).isActive = true
        quoteAuthor.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    func setUpQuoteCategory() -> Void {
        quoteCategory.backgroundColor = UIColor.red
        quoteCategory.font = quoteCategory.font.withSize(16)
        quoteCategory.textAlignment = NSTextAlignment.center
        view.addSubview(quoteCategory)
        quoteCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteCategory.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteCategory.heightAnchor.constraint(equalToConstant: 18).isActive = true
        quoteCategory.bottomAnchor.constraint(equalTo: quoteTimeCreated.topAnchor, constant: 1).isActive = true
        quoteCategory.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func setUpQuoteTimeCreated() -> Void {
        quoteTimeCreated.backgroundColor = UIColor.green
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
        quoteContent.backgroundColor = UIColor.orange
        view.addSubview(quoteContent)
        quoteContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        quoteContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        quoteContent.heightAnchor.constraint(equalToConstant: 100).isActive = true
        quoteContent.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1).isActive = true
        quoteContent.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    
    
}
