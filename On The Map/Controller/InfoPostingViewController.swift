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

    }    

    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
    }
    
}
