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
import Speech

class MapViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    var userInputLocation = FlyoverAwesomePlace.newYork
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "en-us"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        speechRecognizer?.delegate = self
        SFSpeechRecognizer.requestAuthorization {
            status in
            var buttonState = false
            switch status {
            case .authorized:
                buttonState = true
                print("Permission recieved")
            case .denied:
                buttonState = false
                print("User did not grant permssion for speech recognition")
            case .notDetermined:
                buttonState = false
                print("Speech recofgnition not allowed by user")
            case .restricted:
                buttonState = false
                print("Speech recognition is not supported on this device")
                
            }
            
            DispatchQueue.main.async {
                self.locationButton.isEnabled = buttonState
            }
        }
        
        
        locationManager.delegate = self
        mapView.delegate = self
        userLocationSetup()
        self.mapSetup()
//        showRoute()

    }
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Dailed to setup audio session")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Could not create request instance")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) {
            result, error in
            var isLast = false
            if result != nil {
                isLast = (result?.isFinal)!
            }
            
            if error != nil || isLast {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.locationButton.isEnabled = true
                let bestTranscription = result?.bestTranscription.formattedString
                var inDictionary = self.locationDictionary.contains {$0.key == bestTranscription}
                
                if inDictionary {
                    self.userInputLocation = self.locationDictionary[bestTranscription!]!
                } else{
                    self.userInputLocation = FlyoverAwesomePlace.newYork
                }
                self.mapSetup()
            }
        }
        
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format){
            buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
        } catch {
            print("We were not able to start the engine")
        }
        
    }
    
    
    @IBOutlet weak var locationButton: UIButton!
    
    
    @IBAction func locationButtonClicked(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            locationButton.isEnabled = false
            locationButton.setTitle("Record", for: .normal)
        } else {
            startRecording()
            locationButton.setTitle("Stop", for: .normal)
        }
    }
    
    
    
    func mapSetup() {
        self.mapView.mapType = .hybridFlyover
        self.mapView.showsBuildings = true
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        
        let camera = FlyoverCamera(mapView: self.mapView, configuration: FlyoverCamera.Configuration(duration: 6.0, altitude: 60000, pitch: 45.0, headingStep: 40.0))
        camera.start(flyover: FlyoverAwesomePlace.newYork)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(100), execute:{
            camera.stop()
        })
    }
    
    let locationDictionary = [
        "Statue of Liberty": FlyoverAwesomePlace.newYorkStatueOfLiberty,
        "Midtown New York": FlyoverAwesomePlace.centralParkNY,
        "Golden Gate": FlyoverAwesomePlace.sanFranciscoGoldenGateBridge,
        "Miami": FlyoverAwesomePlace.miamiBeach,
        "Rome": FlyoverAwesomePlace.romeColosseum,
        "Big Ben": FlyoverAwesomePlace.londonBigBen,
        "London": FlyoverAwesomePlace.londonEye,
        "Paris": FlyoverAwesomePlace.parisEiffelTower,
        "New York": FlyoverAwesomePlace.newYork,
        "Las Vegas": FlyoverAwesomePlace.luxorResortLasVegas
        
    ]
    
    
    
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
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.758896, longitude: -73.9855)
      
        let empireStateAnnotation = MKPointAnnotation()
        empireStateAnnotation.title = "Hurricane Dorian Clothing Drive"
        empireStateAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
        
        let brooklynBridge = MKPointAnnotation()
        brooklynBridge.title = "Food Pantry Delivery"
        brooklynBridge.coordinate = CLLocationCoordinate2D(latitude: 40.7061, longitude: -73.9969)
        
        let prospectPark = MKPointAnnotation()
        prospectPark.title = "Feed The Homeless Soup Kitchen"
        prospectPark.coordinate = CLLocationCoordinate2D(latitude: 40.6602, longitude: -73.9690)
        
        let jersey = MKPointAnnotation()
        jersey.title = "It's My Park"
        jersey.coordinate = CLLocationCoordinate2D(latitude: 40.7178, longitude: -74.0431)
//
        let miami1 = MKPointAnnotation()
        timesSqaureAnnotation.title = "National Beach Cleansing"
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 25.8098, longitude: -80.1300)
        
        let miami2 = MKPointAnnotation()
        timesSqaureAnnotation.title = "Wildlife Protection Seminar"
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 25.7721, longitude: -80.1359)
        
        let miami3 = MKPointAnnotation()
        timesSqaureAnnotation.title = "Canned Food Packaging"
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 25.8185, longitude: -80.2018)
        
        let miami4 = MKPointAnnotation()
        timesSqaureAnnotation.title = "Refugee Emergency Care"
        timesSqaureAnnotation.coordinate = CLLocationCoordinate2D(latitude: 25.7798, longitude: -80.1945)
        
        mapView.addAnnotation(timesSqaureAnnotation)
        mapView.addAnnotation(empireStateAnnotation)
        mapView.addAnnotation(brooklynBridge)
        mapView.addAnnotation(prospectPark)
        mapView.addAnnotation(jersey)
        
        mapView.addAnnotation(miami1)
        mapView.addAnnotation(miami2)
        mapView.addAnnotation(miami3)
        mapView.addAnnotation(miami4)
    }
    
    func showRoute() {
        let sourceLocation = currentCoordinate ?? CLLocationCoordinate2D(latitude: 40.6742, longitude: -73.8418)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {(response, error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("There was an error getting directions==\(error.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        self.mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }


}






extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

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
        
        showRoute()
        let annView = view.annotation
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            print("detals vc not founds")
            return
        }
       

        
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






