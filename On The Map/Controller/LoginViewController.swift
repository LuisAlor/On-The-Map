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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var activityViewIndicatior: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityViewIndicatior.hidesWhenStopped = true
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
    }

    @IBAction func login(_ sender: Any) {
        setLogin(true)
        UdacityClient.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", completionHandler: handleLoginResponse(success:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(UdacityClient.Endpoints.signUp.url, options: [:], completionHandler: nil)
    }
    
    func showAlert(ofType type: AlertNotification.ofType, message: String){
        let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
        show(alertVC,sender: nil)
        setLogin(false)
    }
    
    func handleLoginResponse(success:Bool, error:Error?){
        if success {
            UdacityClient.getUserData(completionHandler: handleGetUserData(success:error:))
            UdacityClient.getStudentsLocationData(completionHandler: handleStudentsLocationData(data:error:))
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
        } else{
            StudentsLocation.data = data
            setLogin(false)
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
    
    func setLogin(_ isLogin: Bool){
        if isLogin{
            activityViewIndicatior.startAnimating()
        }else{
            activityViewIndicatior.stopAnimating()
        }
        usernameTextField.isEnabled = !isLogin
        passwordTextField.isEnabled = !isLogin
        loginButton.isEnabled = !isLogin
        signUpButton.isEnabled = !isLogin
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

