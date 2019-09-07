//
//  ProfileViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var events:[Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        events = createArray()

//        tableView.delegate = self
//        tableView.dataSource = self
        
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

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let event = events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsViewCell") as! EventsViewCell
        
        cell.setEvent(event: event)
        
        return cell
        
        
    }
    
}
