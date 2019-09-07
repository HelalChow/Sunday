//
//  EventsViewCell.swift
//  hope
//
//  Created by Helal Chowdhury on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit

class EventsViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setEvents(event: Event) {
        eventImageView.image = event.image
        dateLabel.text = event.date
        dayLabel.text = event.day
    }
    
    
    
}
