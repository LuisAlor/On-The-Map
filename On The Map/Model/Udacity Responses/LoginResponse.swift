//
//  LoginResponse.swift
//  On The Map
//
//  Created by Luis Vazquez on 25.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}
