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
    @IBAction func refreshLocation(_ sender: Any) {
        UdacityClient.getStudentsLocationData(completionHandler: handleRefreshStudentsLocation(location:error:))
    }
    
    @IBAction func logout(_ sender: Any) {
        UdacityClient.logout(completionHandler: handleLogout(error:))
    }
    
    func handleLogout(error: Error?){
        if error == nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func handleRefreshStudentsLocation(location: [StudentInformation], error: Error?){
        if let error = error{
            showAlert(ofType: .retrieveUsersLocationFailed, message: error.localizedDescription)
        }else {
            StudentsLocation.data = location
        }
        
        for childViewController in self.children {
            if let mapViewController = childViewController as? MapViewController{
                mapViewController.refresh()
            }else if let tableViewController = childViewController as? TablePinsViewController{
                tableViewController.refresh()
            }
        }
        
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
           let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
           show(alertVC,sender: nil)
    }
}
