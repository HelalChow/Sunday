//
//  MapViewController.swift
//  hope
//
//  Created by Yasin Ehsan on 9/7/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved
//
//Updte

import UIKit
import MapKit
import CoreLocation
import FlyoverKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        userLocationSetup()
        self.mapSetup()
    }
    func mapSetup() {
        self.mapView.mapType = .hybridFlyover
        self.mapView.showsBuildings = true
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        
        let camera = FlyoverCamera(mapView: self.mapView, configuration: FlyoverCamera.Configuration(duration: 6.0, altitude: 40000, pitch: 45.0, headingStep: 40.0))
        camera.start(flyover: FlyoverAwesomePlace.newYork)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(100), execute:{
            camera.stop()
        })
    }
    
    
    
    func userLocationSetup(){
        
        
        locationManager.requestAlwaysAuthorization() //we can ask this later
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.hybrid
    }

    func zoomIn(_ coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    func addAnnotations(){
        
        let timesSqaureAnnotation = MKPointAnnotation()
        timesSqaureAnnotation.title = "9/11 Day of Service"
        timesSqaureAnnotation.subtitle = "This is some mor edeatails..."
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.9855)
//        timesSqaureAnnotation
//        timesSqaureAnnotation.canShowCall
        
        let empireStateAnnotation = MKPointAnnotation()
        empireStateAnnotation.title = "Food Pantry Delivery"
        empireStateAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
        
        let brooklynBridge = MKPointAnnotation()
        brooklynBridge.title = "Hurricane Dorian Clothing Drive"
        brooklynBridge.coordinate = CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969)
        
        let prospectPark = MKPointAnnotation()
        prospectPark.title = "Hurricane Dorian Clothing Drive"
        prospectPark.coordinate = CLLocationCoordinate2D(latitude: 40.6602, longitude: -73.9690)
        
        let jersey = MKPointAnnotation()
        jersey.title = "It's My Park"
        jersey.coordinate = CLLocationCoordinate2D(latitude: 40.7178, longitude: -74.0431)
        
        mapView.addAnnotation(timesSqaureAnnotation)
        mapView.addAnnotation(empireStateAnnotation)
        mapView.addAnnotation(brooklynBridge)
        mapView.addAnnotation(prospectPark)
        mapView.addAnnotation(jersey)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if !(annotation is MKPointAnnotation) {
//            return nil
//        }
//
//        let annotationIdentifier = "AnnotationIdentifier"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView!.canShowCallout = true
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//
//        let pinImage = UIImage(named: "timessq")
//        annotationView!.image = pinImage
//
////        annotationView?.leftCalloutAccessoryView
//
//        return annotationView

//        if annotation is MKUserLocation {
//            return nil
//        }

//        let pin = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        if annotation is MKUserLocation {
            return nil
        }
        else{
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")

            pin.canShowCallout = true
            pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            return pin
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annView = view.annotation
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            print("detals vc not founds")
            return
        }
        
//        detailVC.title = annView?.title ?? "not found"
//        print("kjsdbjkhbfkjdf")
//        let detailVC =" storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.mapView.showsUserLocation = true
        guard let latestLocation = locations.first else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: latestLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        if currentCoordinate == nil{
            zoomIn(latestLocation.coordinate)
            addAnnotations()
        }
        
        currentCoordinate = latestLocation.coordinate
        
        
    }
}
