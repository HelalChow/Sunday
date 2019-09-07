//
//  MapViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLocationSetup()
    }
    
    func userLocationSetup(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() //we can ask this later
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        mapView.showsUserLocation = true
    }

    func zoomIn(_ coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    func addAnnotations(){
        
        let timesSqaureAnnotation = MKPointAnnotation()
        timesSqaureAnnotation.title = "times sq"
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.9855)
        
        let empireStateAnnotation = MKPointAnnotation()
        empireStateAnnotation.title = "empire state"
        empireStateAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
        
        let brooklynBridge = MKPointAnnotation()
        brooklynBridge.title = "bkln bridge"
        brooklynBridge.coordinate = CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969)
        
        mapView.addAnnotation(timesSqaureAnnotation)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else { return }
        
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: latestLocation.coordinate, span: span)
//        mapView.setRegion(region, animated: true)
        
        if currentCoordinate == nil{
            zoomIn(latestLocation.coordinate)
            addAnnotations()
        }
        
        currentCoordinate = latestLocation.coordinate
        
        
    }
}
