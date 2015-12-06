//
//  OMDBAPI.swift
//  Cineast
//
//  Created by David Ehlen on 28.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Foundation

class OMDBAPI: NSObject {
    var delegate: OMDBAPIDelegate?
    
    enum OMDBAPITypes {
        case Movie
        case Series
        case Episode
    }

    func searchByTitle(title:String, type:OMDBAPITypes? = nil,year:Int? = nil) {
        
        let baseUrl = NSURL(string: kBaseURL)!
        var searchQuery="?s=\(title)"

        if let type = type {
            switch(type) {
            case .Movie:
                searchQuery += "&type=movie"
            case .Series:
                searchQuery += "&type=series"
            case .Episode:
                searchQuery += "&type=episode"
            }
        }
        if let year = year {
            searchQuery += "&y=\(year)"
        }
        searchQuery += "&r=json"
        
        let encodedSearchQuery = searchQuery.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
       
        let url = NSURL(string: encodedSearchQuery!, relativeToURL:baseUrl)!
        let request = NSMutableURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            }
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                
                if let results: NSArray = jsonResult?[kSearchKey] as? NSArray {
                    var movieResults:[Movie] = []
                    for dict in results {
                        let movie = Movie(jsonDict: dict as! NSDictionary)
                        movieResults.append(movie)
                    }
                    self.delegate?.didReceiveSearchResults(movieResults)
                }
            }
            catch {
               print("Could not convert result to json dictionary")
            }
            
            
            
        })
        task.resume()
    }

    func advancedSearchByTitle(title:String, type:OMDBAPITypes? = nil,year:Int? = nil, fullPlot:Bool? = false,tomatoes:Bool? = false) {
        var searchQuery="?t=\(title)"
        
        if let type = type {
            switch(type) {
            case .Movie:
                searchQuery += "&type=movie"
            case .Series:
                searchQuery += "&type=series"
            case .Episode:
                searchQuery += "&type=episode"
            }
        }
        if let year = year {
            searchQuery += "&y=\(year)"
        }
        
        if let fullPlot = fullPlot {
            if fullPlot {
                searchQuery += "&plot=full"
            }
            else {
                searchQuery += "&plot=short"
            }
        }
        
        if let tomatoes = tomatoes {
            if tomatoes {
                searchQuery += "&tomatoes=true"
            }
            else {
                searchQuery += "&tomatoes=false"
            }
        }
        
        searchQuery += "&r=json"
        
        let encodedSearchQuery = searchQuery.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        advancedSearchByQuery(encodedSearchQuery!)
    }
    
    func advancedSearchById(id:String, type:OMDBAPITypes? = nil,year:Int? = nil, fullPlot:Bool? = false,tomatoes:Bool? = false) {
        var searchQuery="?i=\(id)"
        
        if let type = type {
            switch(type) {
            case .Movie:
                searchQuery += "&type=movie"
            case .Series:
                searchQuery += "&type=series"
            case .Episode:
                searchQuery += "&type=episode"
            }
        }
        if let year = year {
            searchQuery += "&y=\(year)"
        }
        
        if let fullPlot = fullPlot {
            if fullPlot {
                searchQuery += "&plot=full"
            }
            else {
                searchQuery += "&plot=short"
            }
        }
        
        if let tomatoes = tomatoes {
            if tomatoes {
                searchQuery += "&tomatoes=true"
            }
            else {
                searchQuery += "&tomatoes=false"
            }
        }
        
        searchQuery += "&r=json"
        
       let encodedSearchQuery = searchQuery.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        advancedSearchByQuery(encodedSearchQuery!)

    }
    
    private func advancedSearchByQuery(query:String) {
        let baseUrl = NSURL(string: kBaseURL)!
        let url = NSURL(string: query, relativeToURL:baseUrl)!
        let request = NSMutableURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            }
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                let movie = Movie(jsonDict: jsonResult!)
                let movieResults:[Movie] = [movie]
                self.delegate?.didReceiveSearchResults(movieResults)
            }
            catch {
                print("Could not convert result to json dictionary")
            }
            
        })
        task.resume()

    }
}





protocol OMDBAPIDelegate {
    func didReceiveSearchResults(results: [Movie])
}