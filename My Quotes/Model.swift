//
//  Model.swift
//  My Quotes
//
//  Created by admin on 6/30/17.
//  Copyright © 2017 HVA Software. All rights reserved.
//

class CATEGORY: NSObject {
    var categoryCommentCount: Int = 0
    var categoryLikeCount: Int = 0
    var categoryQuoteCount: Int = 0
    var categoryShareCount: Int = 0
    var categoryCover: String?
    var categoryId: String?
    var categoryIntro: String?
    var categoryName: String?
    var objectId: String?
    var created: Date?
    
    
    
}
class WALLPAPER: NSObject {
    
    
}


class QUOTE: NSObject {
    var quoteCategoryName: String?
    var quoteId: String?
    var quoteContent: String?
    var quoteAuthorName: String?
    var quoteAuthorId: String?
    var quoteCategoryId: String?
    var quoteImage: String?
    var created: NSDate?
    var objectId: String?
    var quoteCommentCount: Int = 0
    var quoteLikeCount: Int = 0
    var quoteShareCount: Int = 0
       
}



class USER: NSObject {
    var userQuoteAuthorId:String?
    var userQuoteAuthorName:String?
    var userQuoteCategoryId:String?
    var userQuoteCategoryName:String?
    var userQuoteContent:String?
    var userQuoteDevice:String?
    var userQuoteId:String?
    var userQuoteLocation:String?
    var created:Date?
    var objectId:String?
    var userQuoteCommentCount:Int = 0
    var userQuoteLikeCount:Int = 0
    var userQuoteShareCount:Int = 0
}



class COMMENT: NSObject {
    var cmAuthor: String?
    var cmContent: String?
    var cmDevice: String?
    var cmLocation: String?
    var cmObjectCommentId: String?
    var created: Date?
    var objectId: String?
    
}



class AUTHOR: NSObject {
    var authorBiography: String?
    var authorBirthday: String?
    var authorCommentCount: Int = 0
    var authorCover: String?
    var authorId: String?
    var authorImage: String?
    var authorJob: String?
    var authorLikeCount: Int = 0
    var authorName: String?
    var authorNationality: String?
    var authorQuoteCount: Int = 0
    var authorShareCount: Int = 0
    var authorWikipedia: String?
    var created: Date?
    var objectId: String?
    
}































class Wallpapers: NSObject {
    
}
