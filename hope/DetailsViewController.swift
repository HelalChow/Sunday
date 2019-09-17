//
//  DetailsViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//Update2

import UIKit
import EventKit
import MapKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        label.text = title

        // Do any additional setup after loading the view.
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        let home = CLLocationCoordinate2D(latitude: 40.6742, longitude: -73.8419)
        let map = MapViewController()
        
        guard var coordinate = map.currentCoordinate else { return home}
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    @IBOutlet weak var jobDetailImageView: UIImageView!
    
    
    @IBAction func registerClicked(_ sender: Any) {
        let eventStore:EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) {(granted, error) in
            if (granted) && (error) == nil
            {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "Hurricane Dorian Clothing Drive"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = ""
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError{
                    print("error : \(error)")
                }
                print("Save Event")
            } else{
                print("error : \(error)")
            }
            
        }
    }
    
    
    @IBAction func routeClicked(_ sender: Any) {
        let sourceLocation = getLocation()
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        
    }
    
}
