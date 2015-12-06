//
//  MovieModel.swift
//  Cineast
//
//  Created by David Ehlen on 28.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Foundation

class Movie {

    var title: String?
    var year: Int?
    var rated: String?
    var releaseDate: NSDate?
    var runtimeMins: Int?
    var genres: [String]?
    var directors: [String]?
    var writers: [String]?
    var actors: [String]?
    var plot: String?
    var languages: [String]?
    var countries: [String]?
    var awards: String?
    var poster: String?
    var metascore: Int?
    var imdbRating: Float?
    var imdbVotes: Int?
    var imdbId: String?
    var error: String?
    var tomatoRatings: RottenTomatoRatings
    
    init(jsonDict: NSDictionary)
    {
        title = jsonDict[kTitleKey] as! String?
        if let s = jsonDict[kYearKey]as! String?
        {
            year = Int(s)
        }
        rated = jsonDict[kRatedKey] as! String?
        if let s = jsonDict[kReleasedKey]as! String?
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd LLL yyyy"
            releaseDate = dateFormatter.dateFromString(s)
        }
        if let s = jsonDict[kRuntimeKey] as! String?
        {
            var parts = s.componentsSeparatedByString(" ")
            if parts.count > 0
            {
                runtimeMins = Int(parts[0])
            }
            
        }
        if let s = jsonDict[kGenreKey]as! String?
        {
            genres = s.componentsSeparatedByString(", ")
        }
        if let s = jsonDict[kDirectorKey] as! String?
        {
            directors = s.componentsSeparatedByString(", ")
        }
        if let s = jsonDict[kWriterKey]as! String?
        {
            writers = s.componentsSeparatedByString(", ")
        }
        if let s = jsonDict[kActorsKey] as! String?
        {
            actors = s.componentsSeparatedByString(", ")
        }
        plot = jsonDict[kPlotKey]as! String?
        if let s = jsonDict[kLanguageKey] as! String?
        {
            languages = s.componentsSeparatedByString(", ")
        }
        if let s = jsonDict[kCountryKey]as! String?
        {
            countries = s.componentsSeparatedByString(", ")
        }
        awards = jsonDict[kAwardsKey] as! String?
        poster = jsonDict[kPosterKey] as! String?
        if let s = jsonDict[kMetascoreKey] as! String?
        {
            metascore = Int(s)
        }
        if let s = jsonDict[kImdbRatingKey] as! String?
        {
            imdbRating = (s as NSString).floatValue
        }
        if let s = jsonDict[kImdbVotesKey] as! String?
        {
            imdbVotes = Int(s.stringByReplacingOccurrencesOfString(",", withString: ""))
        }
        imdbId = jsonDict[kImdbIdKey] as! String?
        error = jsonDict[kErrorKey] as! String?
        tomatoRatings = RottenTomatoRatings(jsonDict: jsonDict)
    }
    
    func description() -> String {
        var titleString = ""
        var yearString = ""
        
        if let title = self.title {
            titleString += title
        }
        
        if let year = self.year {
            yearString += "\(year)"
        }
        return "\(titleString) (\(yearString))"
    }
    
}
