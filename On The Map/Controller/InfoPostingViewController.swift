//
//  InfoPostingViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 23.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit

class InfoPostingViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mediaURLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationTextField.text = ""
        self.mediaURLTextField.text = ""

    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if self.locationTextField.text != "" && self.mediaURLTextField.text != "" {
            performSegue(withIdentifier: "addLocationSegue", sender: nil)
        }else{
            showAlert(ofType: .emptyFields, message: "Some of the fields are still empty")
        }
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
           let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
           present(alertVC, animated: true)
    }
    
}
