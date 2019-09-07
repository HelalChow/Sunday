//
//  ProfileViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var events:[Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    func createArray() -> [Event] {
        var tempEvents: [Event] = []
        
        let event1 = Event(image: UIImage(named: "Food")!, date: "8", day: "Sun")
        let event2 = Event(image: UIImage(named: "911")!, date: "11", day: "Tue")
        let event3 = Event(image: UIImage(named: "Park")!, date: "24", day: "Wed")
        
        tempEvents.append(event1)
        tempEvents.append(event2)
        tempEvents.append(event3)
        
        
        return tempEvents
    }
    
    
    @IBOutlet weak var numEventsLabel: UILabel!
    

    

}
