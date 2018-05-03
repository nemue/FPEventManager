//
//  ViewController.swift
//  secondApp
//
//  Created by Nele Müller on 19.03.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let cellIdentifier = "EventTableViewCell"
    private var events: [Event] = []
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // generateSampleEvents()
    }
    
    // MARK: – UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.events.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? EventTableViewCell
            else{
                fatalError("The dequeued cell is not an instance of EventTableViewCell")
        }
        
        let event = self.events[indexPath.row]
        cell.configureCell(eventInRow: event)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: respond to touch events
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? EventDetailTableViewController{
            let newIndexPath = IndexPath(row: self.events.count, section: 0)
            
            let event = sourceViewController.getEvent()
            self.events.append(event)
            self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    // MARK: - Private Methods
    
    private func generateSampleEvents () {
        
        let date = Date()
        
        let event1 = Event(title: "erstes Event", date: date)
        let event2 = Event(title: "zweites Event", location: "da", date: date)
        let event3 = Event(title: "drittes Event", location: "Berlin", date: date)
        let event4 = Event(title: "viertes Event", location: "Leipzig", date: date, allDay: true)
        
        self.events = [event1, event2, event3, event4]
    }

}

