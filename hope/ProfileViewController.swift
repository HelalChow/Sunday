//
//  ProfileViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import UserNotifications


class ProfileViewController: UIViewController {
    
    @IBOutlet weak var eventTableView: UITableView!
//    @IBOutlet weak var numEventsLabel: UILabel!
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        events = createArray()
        
    }
    
    func createArray() -> [Event] {
        let tempBool: [Event] = [Event.e1, Event.e2, Event.e3, Event.e4]
        print("1")
        return tempBool
        
    }
    
//    @IBAction func createBool(segue:UIStoryboardSegue) {
//        let addBoolVC = segue.source as! AddBoolViewController
////        guard let destination: MKPlacemark = addBoolVC.boolLocation else { return }
//        
//        let newBool = Bools(suggester: "add bool meet at", time: destination.name ?? "", likes: 7)
//        
//        newBool.destination = destination
//        
//        boolList.append(newBool)
//        boolTableView.reloadData()
//    }

    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        print("10")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell") as! EventsViewCell
        print("100")
        
        cell.setEvents(event: event)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
