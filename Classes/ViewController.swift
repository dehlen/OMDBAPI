//
//  ViewController.swift
//  OMDBAPI
//
//  Created by David Ehlen on 28.07.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, OMDBAPIDelegate {
    
    var omdbAPI = OMDBAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        omdbAPI.delegate = self
        omdbAPI.searchByTitle("Inception",type:.Movie,year:2010)
        omdbAPI.advancedSearchByTitle("Inception")
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func didReceiveSearchResults(results: [Movie]) {
        print(results)
        for movie in results {
            print(movie.description())
        }
    }
    
}

