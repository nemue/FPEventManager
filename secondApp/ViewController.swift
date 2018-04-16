//
//  ViewController.swift
//  secondApp
//
//  Created by Nele Müller on 19.03.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    let cellIdentifier = "CellIdentifier"
    var dates: [String] = []

    
    // MARK: – UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = dates.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let date = dates[indexPath.row]
        
        cell.textLabel?.text = date
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: respond to touch events
        let date = dates[indexPath.row]
        print(date)
    }
    
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: ersetzen mit Date-Klasse-Array
        dates = ["erstes Date", "zweites Date", "drittes Date", "viertes Date"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

