//
//  ProfileViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var numEventsLabel: UILabel!
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        events = createArray()
        eventTableView.delegate = self
        eventTableView.dataSource = self
    }
    
    func createArray() -> [Event] {
        let tempBool: [Event] = [Event.e1, Event.e2, Event.e3, Event.e4]
        return tempBool
        
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell") as! EventsViewCell
        
        cell.setEvents(event: event)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
