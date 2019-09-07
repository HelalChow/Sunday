//
//  Event.swift
//  hope
//
//  Created by Helal Chowdhury on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var image: UIImage
    var date: String
    var day: String
    
    init(image: UIImage, date: String, day: String) {
        self.image = image
        self.date = date
        self.day = day
    }
}
