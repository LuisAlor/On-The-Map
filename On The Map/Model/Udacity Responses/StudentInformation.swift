//
//  StudentLocation.swift
//  On The Map
//
//  Created by Luis Vazquez on 26.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
}

