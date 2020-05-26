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
    }

    @IBAction func login(_ sender: Any) {
        UdacityClient.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { (success, error) in
            if success{
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
            else {
                self.showLoginFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showLoginFailure(message: String){
           let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           show(alertVC, sender: nil)
    }
    
}

