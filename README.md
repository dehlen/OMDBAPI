# OMDBAPI

This repository, written in Swift, provides a simple wrapper to use the API endpoints of [omdbapi.com](http://omdbapi.com).

The model classes are heavily inspired by : [OMDB_Search_iOS](https://github.com/gpaz/OMDB_Search_iOS/tree/master/OMDbSearch). The models were converted to Swift 2.0 Syntax.
Some of the networking code was inspired by : [OMDBSearch](https://github.com/jeremyfrick/OMDB-Search/tree/master/OMDB%20Search). 

This library adds some methods to the API wrapper in order to make it easier and to prevent mistakes by calling the API.

Supported method declarations:
```swift
func searchByTitle(title:String, type:OMDBAPITypes? = nil,year:Int? = nil)
    
func advancedSearchByTitle(title:String, type:OMDBAPITypes? = nil,year:Int? = nil, fullPlot:Bool? = false,tomatoes:Bool? = false)
	
func advancedSearchById(id:String, type:OMDBAPITypes? = nil,year:Int? = nil, fullPlot:Bool? = false,tomatoes:Bool? = false)

```

As you can see the function take multiple optional parameters since it is not necessary that this methods are provided, but if you want you can. It is also more convenient to call this functions instead of providing a query string like "baseUrl/?s=title&r=json&...". You do not need to know the API in order to use this wrapper.

## Setup
Copy 

- Movie.swift
- RottenTomatoRatings.swift
- APIConstants.swift
- OMDBAPI.swift

to your project.

## Usage

For a demo have a look at ViewController.swift.

```swift

class ViewController: NSViewController, OMDBAPIDelegate {
    //1. Create reference
    var omdbAPI = OMDBAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        //2. Set delegate
        omdbAPI.delegate = self
        //3. Call functions
        omdbAPI.searchByTitle("Inception")
        //omdbAPI.searchByTitle("Inception",type:.Movie,year:2010)
        omdbAPI.advancedSearchByTitle("Inception")
        //omdbAPI.advancedSearchByTitle("Inception",type:.Movie,year:2010,fullPlot:true, tomatoes:true)
        omdbAPI.advancedSearchById("tt1375666")
        //omdbAPI.advancedSearchById("tt1375666",type:.Movie,year:2010,fullPlot:true, tomatoes:true)
       
    }
    
    //4. Implement the needed delegate method
    func didReceiveSearchResults(results: [Movie]) {
        for movie in results {
            print(movie.description())
        }
    }


```

## Licence #
```
The MIT License (MIT)

Copyright (c) 2015 David Ehlen (dehlen)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
