//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 02.06.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var studentInfo : StudentLocationRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.mapView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        generatePointInMap()
    }

    @IBAction func submitLocation(_ sender: Any) {
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func generatePointInMap(){
        
        var annotations = [MKPointAnnotation]()

        let lat = CLLocationDegrees(studentInfo.latitude)
        let long = CLLocationDegrees(studentInfo.longitude)

        // The lat and long to create a CLLocationCoordinates2D instance.
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

        // Here we create the annotation and set its coordiate, title, and subtitle properties
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate

        // Place the annotation in an array of annotations.
        annotations.append(annotation)

        // When the array is complete, add the annotations to the map.
        self.mapView.addAnnotations(annotations)
        
        centerMapOnLocation(CLLocation(latitude: lat, longitude: long), mapView: mapView)
    }
}

extension AddLocationViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
}
