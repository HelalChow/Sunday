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

//dummy varaibles
extension Event {
    static let e1 = Event(image: UIImage(named: "3-3") ?? UIImage(), date: "8", day: "Mon")
    static let e2 = Event(image: UIImage(named: "3-2") ?? UIImage(), date: "15", day: "Tue")
    static let e3 = Event(image: UIImage(named: "3-1") ?? UIImage(), date: "29", day: "Sun")
    static let e4 = Event(image: UIImage(named: "3") ?? UIImage(), date: "14", day: "Mon")
}

