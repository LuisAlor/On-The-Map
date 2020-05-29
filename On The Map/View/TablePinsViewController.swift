//
//  TablePinsViewController.swift
//  On The Map
//
//  Created by Luis Vazquez on 23.05.2020.
//  Copyright © 2020 Alortechs. All rights reserved.
//

import UIKit

class TablePinsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}

extension TablePinsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsLocation.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pinCell", for: indexPath)
        let studentInfo = StudentsLocation.data[indexPath.row]
        cell.textLabel?.text = "\(studentInfo.firstName) \(studentInfo.lastName)"
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mediaURL = StudentsLocation.data[indexPath.row].mediaURL
        let alternativeURL = URL(string: "https://google.com")!
        tableView.deselectRow(at: indexPath, animated: true)
       
        if let mediaURL = URL(string: mediaURL){
            UIApplication.shared.open(mediaURL, options: [:], completionHandler: nil)
        }else{
            UIApplication.shared.open(alternativeURL, options: [:], completionHandler: nil)
        }
    }
}
