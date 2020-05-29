//
//  LoginViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 22.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        usernameTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func login(_ sender: Any) {
        UdacityClient.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", completionHandler: handleLoginResponse(success:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(UdacityClient.Endpoints.signUp.url, options: [:], completionHandler: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
        let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
        show(alertVC,sender: nil)

    }
    
    func handleLoginResponse(success:Bool, error:Error?){
        if success {
            UdacityClient.getUserData(completionHandler: handleGetUserData(success:error:))
            UdacityClient.getStudentsLocationData(completionHandler: handleStudentsLocationData(data:error:))
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            self.showAlert(ofType: .loginFailed, message: error?.localizedDescription ?? "")
        }
    }
    
    func handleGetUserData(success: Bool, error: Error?){
        if !success {
            self.showAlert(ofType: .retrieveUserDataFailed, message: error?.localizedDescription ?? "")
        }
    }
    
    func handleStudentsLocationData(data: [StudentInformation], error: Error? ){
        if error != nil {
            self.showAlert(ofType: .retrieveUsersLocationFailed, message: error?.localizedDescription ?? "")
        } else {
            print(data)
        }
    }
    
}

