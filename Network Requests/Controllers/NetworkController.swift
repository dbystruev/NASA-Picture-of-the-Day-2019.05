//
//  NetworkController.swift
//  Network Requests
//
//  Created by Denis Bystruev on 25/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

final class NetworkController {
    func fetchPhotoInfo(from url: URL, completion: @escaping (PhotoInfo?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let photoDictionary = try? jsonDecoder.decode(PhotoInfo.self, from: data)
            completion(photoDictionary)
        }
        
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
