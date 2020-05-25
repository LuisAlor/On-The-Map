//
//  LoginViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 22.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        UdacityClient.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { (success, error) in
            if success{
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
            else {
                print("Failed")
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
}

