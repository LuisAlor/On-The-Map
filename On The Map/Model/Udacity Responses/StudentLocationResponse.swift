//
//  StudentLocationResponse.swift
//  On The Map
//
//  Created by Luis Vazquez on 26.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

struct StudentLocationResponse: Codable {
    let results: [StudentInformation]
}
