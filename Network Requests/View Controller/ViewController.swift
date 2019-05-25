//
//  ViewController.swift
//  Network Requests
//
//  Created by Denis Bystruev on 20/05/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    let url = URL(string: "https://api.nasa.gov/planetary/apod")!
    let queries = [
        "api_key": "DEMO_KEY",
        "date": "2019-05-19"
    ]
    var photoInfo: PhotoInfo?
    var image: UIImage?
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        transition(to: view.bounds.size)
        
        guard let apiURL = url.withQueries(queries) else {
            print(#line, #function, "Can't convert \(url)")
            return
        }
        
        let networkManager = NetworkManager()
        
        networkManager.fetchPhotoInfo(from: apiURL) { photoInfo in
            guard let photoInfo = photoInfo else {
                print(#line, #function, "Can't load data from \(self.url)")
                return
            }
            
            self.photoInfo = photoInfo
            self.updateUI()
            
            networkManager.fetchImage(from: photoInfo.url) { image in
                self.image = image
                self.updateUI()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        transition(to: size)
    }
    
    // MARK: - Methods
    func transition(to size: CGSize) {
        if size.width < size.height {
            topStackView.axis = .vertical
            topStackView.spacing = 0
            widthConstraint.priority = .defaultLow
            heightConstraint.priority = .defaultHigh
        } else {
            topStackView.axis = .horizontal
            topStackView.spacing = 16
            widthConstraint.priority = .defaultHigh
            heightConstraint.priority = .defaultLow
        }
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.imageView.image = self.image
            guard let photoInfo = self.photoInfo else { return }
            self.title = photoInfo.title
            self.descriptionLabel.text = photoInfo.description
            if let copyrightText = photoInfo.copyright {
                self.copyrightLabel.text = "© \(copyrightText)"
            }
        }
    }
}

