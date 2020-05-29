//
//  AlertType.swift
//  On The Map
//
//  Created by Luis Vazquez on 29.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import Foundation

class AlertNotification{
    
    struct Titles {
        let ofController: String
        let ofAction: String
    }
    
    enum ofType {
        case loginFailed
        case retrieveUserDataFailed

        var getTitles: Titles{
            switch self {
            case .loginFailed:
                return Titles(ofController: "Login Failed", ofAction: "Ok")
            case .retrieveUserDataFailed:
                return Titles(ofController: "Retrieving Data Failed", ofAction: "Ok")
            }
        }
    }
}
    

