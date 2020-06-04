//
//  LoginViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 22.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityViewIndicatior: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide activity indicatory when stops
        self.activityViewIndicatior.hidesWhenStopped = true
        
        //Assign delegates for textFields
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //Set textfields to empty
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
    }

    //MARK: - login: Login if the user pressed the button
    @IBAction func login(_ sender: Any) {
        setLogin(true)
        UdacityClient.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", completionHandler: handleLoginResponse(success:error:))
    }
    //MARK: - signUp: Open Sign Up Page from Udacity
    @IBAction func signUp(_ sender: Any) {
        UIApplication.shared.open(UdacityClient.Endpoints.signUp.url, options: [:], completionHandler: nil)
    }
    //MARK: - showAlert: Create an alert with dynamic titles according to the type of error
    func showAlert(ofType type: AlertNotification.ofType, message: String){
        let alertVC = UIAlertController(title: type.getTitles.ofController, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: type.getTitles.ofAction, style: .default, handler: nil))
        show(alertVC,sender: nil)
        setLogin(false)
    }
    
    //MARK: - handleLoginResponse: If successful login getuser info and student locations
    func handleLoginResponse(success:Bool, error:Error?){
        if success {
            UdacityClient.getUserData(completionHandler: handleGetUserData(success:error:))
            UdacityClient.getStudentsLocationData(completionHandler: handleStudentsLocationData(data:error:))
        } else {
            self.showAlert(ofType: .loginFailed, message: error?.localizedDescription ?? "")
        }
    }
    
    //MARK: - handleGetUserData: If userdata failed to retrieve show alert
    func handleGetUserData(success: Bool, error: Error?){
        if !success {
            self.showAlert(ofType: .retrieveUserDataFailed, message: error?.localizedDescription ?? "")
        }
    }
    //MARK: - handleStudentsLocationData: If user locations was successful save if not show alert
    func handleStudentsLocationData(data: [StudentInformation], error: Error? ){
        if error != nil {
            self.showAlert(ofType: .retrieveUsersLocationFailed, message: error?.localizedDescription ?? "")
        } else{
            StudentsLocation.data = data
            setLogin(false)
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
    //MARK: - setLogin: Control the activityViewIndicatior when to start and stop animating
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
    
    //MARK: textFieldShouldReturn: Dismiss keyboard if return was pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

