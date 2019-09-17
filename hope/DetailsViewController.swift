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

class DetailsViewController: UIViewController, MKMapViewDelegate {
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
        return coordinate
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    let map = MapViewController()
    
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
//        let sourceLocation = getLocation()
//        let destinationLocation = CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969)
//
//        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
//        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
//
//        let directionRequest = MKDirections.Request()
//        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
//        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
//        directionRequest.transportType = .automobile
//
//        let directions = MKDirections(request: directionRequest)
//        directions.calculate {(response, error) in
//            guard let directionResponse = response else {
//                if let error = error{
//                    print("There was an error getting directions==\(error.localizedDescription)")
//                }
//                return
//            }
//            let route = directionResponse.routes[0]
//            self.map.mapView.addOverlay(route.polyline, level: .aboveRoads)
//
//            let rect = route.polyline.boundingMapRect
//            self.map.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
//        }
//
//        self.map.mapView.delegate = self
    }
    
    
    
    
}
