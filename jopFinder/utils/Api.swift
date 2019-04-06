//
//  Api.swift
//  jopFinder
//
//  Created by Deema on 4/4/19.
//  Copyright © 2019 Deema. All rights reserved.
//

import Foundation
import Networking

class Api {
    static private var _networking: Networking? = nil
    static var baseURL:String!
    static var networking: Networking {
        get {
            _networking = Networking(baseURL:baseURL!)
            return _networking!
        }
    }
}


