//
//  ViewController.swift
//  Network Requests
//
//  Created by Denis Bystruev on 20/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let url = URL(string: "https://api.nasa.gov/planetary/apod")!
    let queries = [
        "api_key": "DEMO_KEY",
        "date": "2019-05-19"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let apiURL = url.withQueries(queries) else {
            print(#line, #function, "Can't convert \(url)")
            return
        }
        
        print(#line, #function, apiURL)
        
        let networkManager = NetworkController()
        
        networkManager.fetchPhotoInfo(from: apiURL) { photoInfo in
            guard let photoInfo = photoInfo else {
                print(#line, #function, "Can't load data from \(self.url)")
                return
            }
            networkManager.fetchImage(from: photoInfo.url) { image in
                print(#line, #function, image?.description ?? "nil")
            }
        }
    }


}

