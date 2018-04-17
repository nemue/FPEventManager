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
    
    let cellIdentifier = "EventTableViewCell"
    var events: [Event] = []

    
    // MARK: – UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = events.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell
            else{
                fatalError("The dequeued cell is not an instance of EventTableViewCell")
        }
        
        let event = events[indexPath.row]
        cell.eventTitleLabel.text = event.title + ", " + event.location!
        cell.eventDateLabel.text = event.date
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: respond to touch events
        let event = events[indexPath.row]
        print(event.title)
        print(event.date)
    }
    
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateSampleEvents()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Private Methods
    
    private func generateSampleEvents () {
        
        guard let event1 = Event(title: "erstes Event", location: "hier", date: "heute")
            else {
                fatalError("Unable to instantiate Event 1")
        }
        
        guard let event2 = Event(title: "zweites Event", location: "da", date: "morgen")
            else {
                fatalError("Unable to instantiate Event 2")
        }
        
        guard let event3 = Event(title: "drittes Event", location: "Berlin", date: "niemals")
            else {
                fatalError("Unable to instantiate Event 3")
        }
        
        guard let event4 = Event(title: "viertes Event", location: "Leipzig", date: "immer")
            else {
                fatalError("Unable to instantiate Event 4")
        }
        
        events += [event1, event2, event3, event4]
    }

}

