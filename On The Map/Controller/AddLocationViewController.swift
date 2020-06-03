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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func submitLocation(_ sender: Any) {
    }
}

extension AddLocationViewController: MKMapViewDelegate{
    
}
