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
    
    var studentInfo : StudentLocationRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationTextField.text = ""
        self.mediaURLTextField.text = ""
        self.locationTextField.delegate = self
        self.mediaURLTextField.delegate = self

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationSegue"{
            let controller = segue.destination as! AddLocationViewController
            controller.studentInfo = StudentLocationRequest(uniqueKey: UdacityClient.Auth.uniqueKey, firstName: UdacityClient.userInfo.firstName, lastName: UdacityClient.userInfo.lastName, mapString: locationTextField?.text ?? "", mediaURL: mediaURLTextField?.text ?? "", latitude: 20, longitude: 20)
        }
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
           let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
           present(alertVC, animated: true)
    }
    
}

extension InfoPostingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
