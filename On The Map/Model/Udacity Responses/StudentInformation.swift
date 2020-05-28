//
//  StudentLocation.swift
//  On The Map
//
//  Created by Luis Vazquez on 26.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
    
}
