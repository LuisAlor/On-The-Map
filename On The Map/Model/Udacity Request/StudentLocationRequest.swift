//
//  StudentLocationRequest.swift
//  On The Map
//
//  Created by Luis Vazquez on 26.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

struct StudentLocationRequest:Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
}
