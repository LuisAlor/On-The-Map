//
//  MapViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 23.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        var annotations = [MKPointAnnotation]()
        
        for dictionary in StudentsLocation.data {
            
            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            
            // The lat and long to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        // When the array is complete, add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
        let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
        show(alertVC,sender: nil)
    }
}

extension MapViewController: MKMapViewDelegate{
       
    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // Delegate method for responding to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let mediaURL = view.annotation?.subtitle! {
                if mediaURL.contains("https") {
                    UIApplication.shared.open(URL(string: mediaURL)!)
                }else{
                    showAlert(ofType: .incorrectURLFormat, message: "Media contains a wrong URL format")
                }
            } else {
                showAlert(ofType: .emptyMediaURL, message: "The user didn't provide an URL")
            }
        }
    }
}
