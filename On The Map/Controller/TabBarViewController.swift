//
//  TabBarViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 01.06.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func refreshLocationData(_ sender: Any) {
    }
    
    @IBAction func addLocation(_ sender: Any) {
    }
    
    @IBAction func logout(_ sender: Any) {
        UdacityClient.logout(completionHandler: handleLogout(error:))
    }
    
    func handleLogout(error: Error?){
        
        if error == nil {
            dismiss(animated: true, completion: nil)
        }
    }
}
