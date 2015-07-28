//
//  RottenTomatoRatings.swift
//  Cineast
//
//  Created by David Ehlen on 28.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Foundation

class RottenTomatoRatings
{
    var tomatoMeter: Int?
    var tomatoImage: String?
    var tomatoRating: Float?
    var tomatoReviews: Int?
    var tomatoFresh: Int?
    var tomatoRotten: Int?
    var tomatoConsensus: String?
    var tomatoUserMeter: Int?
    var tomatoUserRating: Float?
    var tomatoUserReviews: Int?
    var dvdReleaseDate: NSDate?
    var boxOfficeRevenueMillions: Float?
    var production: String?
    var website: String?
    
    init(jsonDict: NSDictionary)
    {
        if let s = jsonDict[kTomatoMeter] as! String?
        {
            tomatoMeter = Int(s)
        }
        tomatoImage = jsonDict[kTomatoImage] as! String?
        if let s = jsonDict[kTomatoRating] as! String?
        {
            tomatoRating = (s as NSString).floatValue
        }
        if let s = jsonDict[kTomatoReviews] as! String?
        {
            tomatoReviews = Int(s.stringByReplacingOccurrencesOfString(",", withString: ""))
        }
        if let s = jsonDict[kTomatoFresh] as! String?
        {
            tomatoFresh = Int(s.stringByReplacingOccurrencesOfString(",", withString: ""))
        }
        if let s = jsonDict[kTomatoRotten] as! String?
        {
            tomatoRotten = Int(s.stringByReplacingOccurrencesOfString(",", withString: ""))
        }
        tomatoConsensus = jsonDict[kTomatoConsensus] as! String?
        if let s = jsonDict[kTomatoUserMeter] as! String?
        {
            tomatoUserMeter = Int(s)
        }
        if let s = jsonDict[kTomatoUserRating] as! String?
        {
            tomatoUserRating = (s as NSString).floatValue
        }
        if let s = jsonDict[kTomatoUserReviews] as! String?
        {
            tomatoUserReviews = Int(s.stringByReplacingOccurrencesOfString(",", withString: ""))
        }
        if let s = jsonDict[kDVD] as! String?
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd LLL yyyy"
            dvdReleaseDate = dateFormatter.dateFromString(s)
        }
        if let s = jsonDict[kBoxOffice] as! String?
        {
            let floatStr = s.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "$M"))
            boxOfficeRevenueMillions = (floatStr as NSString).floatValue
        }
        production = jsonDict[kProduction] as! String?
        website = jsonDict[kWebsite] as! String?
    }
}