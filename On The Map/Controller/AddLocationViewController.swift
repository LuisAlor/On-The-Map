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

    }

    @IBAction func submitLocation(_ sender: Any) {
    }
}

func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
    let regionRadius: CLLocationDistance = 1000
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
}

extension AddLocationViewController: MKMapViewDelegate{
    
    
    
}
