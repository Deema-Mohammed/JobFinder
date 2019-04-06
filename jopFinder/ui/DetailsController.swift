//
//  DetailsController.swift
//  jopFinder
//
//  Created by Deema on 4/4/19.
//  Copyright © 2019 Deema. All rights reserved.
//

import UIKit
import WebKit

class DetailsController: UIViewController {
    var url:String?
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageURL = URL(string:url!)
            webview.load(URLRequest(url: pageURL!))
        
    }

    
}
