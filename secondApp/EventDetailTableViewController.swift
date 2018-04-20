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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let userCalendar = Calendar.current
    
    var event: Event?
    var date: Date?
    
    var datePickerOpen = false
    
    // MARK: - ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        date = Date ()
        guard let currentDate = date else{
            return
        }
        
        updateDateAndLabel(date: currentDate, displayTime: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        guard let date = self.date else {
            return
        }
        
        event =  Event(title: title!, location: location, date: date, allDay: allDay)
     }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Date Picker
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1 && indexPath.row == 1){
            if(!datePickerOpen){
                datePickerCell.isHidden = false
                datePickerOpen = true
                
                updateDateAndLabel(date: datePicker.date,
                                   displayTime: !allDaySwitch.isOn)
            }
            else{
                datePickerCell.isHidden = true
                datePickerOpen = false
            }

        }
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        updateDateAndLabel(date: datePicker.date, displayTime: !allDaySwitch.isOn)
    }
    
    @IBAction func switchStateChanged(_ sender: UISwitch) {
        updateDateAndLabel(date: datePicker.date, displayTime: !allDaySwitch.isOn)
    }
    
    
    // MARK: - Private Methods
    
    private func updateDateAndLabel(date: Date, displayTime: Bool) {
        dateLabel.text = Event.dateToString(toBeConverted: date, time: displayTime)
        self.date = datePicker.date
        
        if (displayTime){
            let calender = userCalendar
            self.date = calender.startOfDay(for: date)
        }
        
        print(Event.dateToString(toBeConverted: date, time: displayTime))
    }
    
    // löschen:
    private func eventToArray(event: Event ) -> [[String]]{
        var resultEvent = [[String]] ()
        
        guard let location = event.location else {
            fatalError("Event has no location")
        }
        
        resultEvent += [[event.title, location], [String(describing: event.date)]]
        
        return resultEvent
    }

}
