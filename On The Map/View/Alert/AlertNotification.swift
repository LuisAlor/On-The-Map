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
        case retrieveUsersLocationFailed
        case incorrectURLFormat
        case emptyMediaURL

        var getTitles: Titles{
            switch self {
            case .loginFailed:
                return Titles(ofController: "Login Failed", ofAction: "Ok")
            case .retrieveUserDataFailed:
                return Titles(ofController: "Get User Info Failed", ofAction: "Ok")
            case .retrieveUsersLocationFailed:
                return Titles(ofController: "Get Users Location Failed", ofAction: "Ok")
            case .incorrectURLFormat:
                return Titles(ofController: "Failed to open URL", ofAction: "Ok")
            case .emptyMediaURL:
                return Titles(ofController: "Blank URL Field", ofAction: "Ok")
            }
        }
    }
}
    

