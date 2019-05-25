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
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let apiURL = components?.url else {
            print(#line, #function, "Can't convert \(url)")
            return
        }
        
        print(#line, #function, apiURL)
        
        let task = URLSession.shared.dataTask(with: apiURL) { data, response, error in
            guard let data = data else {
                print(#line, #function, error?.localizedDescription ?? "nil")
                return
            }
            
            print(#line, #function, data, "received")
            
            guard let text = String(data: data, encoding: .utf8) else {
                print(#line, #function, "Can't decode data")
                return
            }
            
            print(#line, #function, text)
        }
        
        task.resume()
    }


}

