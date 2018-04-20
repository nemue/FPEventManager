//
//  EventDetailTableViewController.swift
//  secondApp
//
//  Created by Nele Müller on 17.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit
import os.log

class EventDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var allDaySwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    
    var event: Event?
    var eventDetails = [[String]] ()
    var sampleEvent = Event(title: "Beispiel", location: "Beispiel", date: "Beispiel")  // TODO (Edit Event)
    var datePicked = false
    
    // MARK: - ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // eventDetails = eventToArray(event: sampleEvent!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        print("number of sections: \(eventDetails.count)") // XXX
//        return eventDetails.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("row in section: \(eventDetails[section].count)") // XXX
//        return eventDetails[section].count
//    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === addButton else {
            os_log("The add button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = titleTextField.text
        let location = locationTextField.text
        let allDay = allDaySwitch.isOn
        let date = "date" // TODO

        
        print(allDaySwitch.isOn) // XXX
        
        event =  Event(title: title!, location: location, date: date, allDay: allDay)
     }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: -
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1 && indexPath.row == 2){
            showDatePicker()
        }
    }
    
    
    // MARK: - Private Methods
    
    private func eventToArray(event: Event ) -> [[String]]{
        var resultEvent = [[String]] ()
        
        guard let location = event.location else {
            fatalError("Event has no location")
        }
        
        resultEvent += [[event.title, location], [event.date]]
        
        return resultEvent
    }
    
    func showDatePicker(){
        datePickerCell.isHidden = false // TODO
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
