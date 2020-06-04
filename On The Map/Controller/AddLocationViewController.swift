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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var finishButton: UIButton!
    
    var mapString: String!
    var mediaURL: String!
    var geoLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        activityIndicatorView.hidesWhenStopped = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        generatePointInMap()
    }

    @IBAction func submitLocation(_ sender: Any) {
        isPostingLocation(true)
        UdacityClient.createStudentLocation(mapString: mapString, mediaURL: mediaURL, coordinates: (geoLocation.latitude,   geoLocation.longitude), completionHandler: handleCreateLocationResponse(success:error:))
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func generatePointInMap(){
        
        var annotations = [MKPointAnnotation]()

        let lat = CLLocationDegrees(geoLocation.latitude)
        let long = CLLocationDegrees(geoLocation.longitude)

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
    
    func handleCreateLocationResponse(success: Bool, error: Error?){
        if success {
            isPostingLocation(false)
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(ofType: .createLocationFailed, message: error?.localizedDescription ?? "")
        }
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
        let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
        present(alertVC, animated: true)
        isPostingLocation(false)
    }
    
    func isPostingLocation(_ hasPosted: Bool){
        if hasPosted{
            activityIndicatorView.startAnimating()
        }else{
            activityIndicatorView.stopAnimating()
        }
        finishButton.isEnabled = !hasPosted
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
