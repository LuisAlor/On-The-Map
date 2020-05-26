//
//  UdacityErrorResponse.swift
//  On The Map
//
//  Created by Luis Vazquez on 26.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

struct UdacityErrorResponse: Codable, Error {
    let status: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case message = "error"
    }
}

extension UdacityErrorResponse: LocalizedError {
    var errorDescription: String? {
        return message
    }
}
