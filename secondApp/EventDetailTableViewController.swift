//
//  EventDetailTableViewController.swift
//  secondApp
//
//  Created by Nele Müller on 17.04.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import UIKit
import os.log

class EventDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var addButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    private let userCalendar = Calendar.current
    private let textCellIdentifier = "EventDetailTextCell"
    private let allDaySwitchCellIdentifier = "EventDetailAllDaySwitchCell"
    private let dateCellIdentifier = "EventDetailDateCell"
    private let datePickerCellIdentifier = "EventDetailDatePickerCell"

    private var eventDate: Date = Date()
    var event: Event!
    private var eventTitle: String?
    private var eventLocation: String?
    private var indexPathForDateLabelCell: IndexPath?
    private var eventArray = [[EventInfo]]()
    private var datePickerIsShown = false
    
    // MARK: - ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.event = Event(date: self.eventDate)
        saveEventToArray()
        
        updateAddButtonState()
    }

    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === addButton else {
            os_log("The add button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray[section].count
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var resultCell = UITableViewCell()
        
        switch eventArray[indexPath.section][indexPath.row] {
            
        case let EventInfo.text(text):
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as? EventDetailTextCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailTextCell")
            }
            
            let textCellTag = indexPath.row
            
            textCell.configure(textFieldDelegate: self, text: text, tag: textCellTag)
            resultCell = textCell
            
        case let EventInfo.uiSwitch(switchIsOn):
            guard let switchCell = tableView.dequeueReusableCell(withIdentifier: allDaySwitchCellIdentifier, for: indexPath) as? EventDetailAlldaySwitchCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailAlldaySwitchCell")
            }
            
            switchCell.configure(switchIsOn: switchIsOn, onSwitchValueChangedHandler: {(isSwitchOn: Bool) in
                let switchInfo = EventInfo.uiSwitch(isSwitchOn)
                self.updateEventAndArray(eventInfo: switchInfo)
                
                let dateInfo = EventInfo.date(self.changeDateIfAllDaySwitchIsOn(date: self.event.date))
                self.updateEventAndArray(eventInfo: dateInfo)
                
                self.updateDateLabelCell()
            })
            resultCell = switchCell
            
        case let EventInfo.date(date):
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: dateCellIdentifier, for: indexPath) as? EventDetailDateCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailTextCell")
            }
            
            indexPathForDateLabelCell = indexPath
            
            dateCell.configure(date: date, allDay: event.allDay ?? false)
            resultCell = dateCell
            
        case EventInfo.datePicker:

            guard let datePickerCell = tableView.dequeueReusableCell(withIdentifier: datePickerCellIdentifier, for: indexPath) as? EventDetailDatePickerCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailDatePickerCell")
                }
            
            let dateChangedHandler = { (newDate: Date) in
                let date = self.changeDateIfAllDaySwitchIsOn(date: newDate)
                
                let dateInfo = EventInfo.date(date)
                self.updateEventAndArray(eventInfo: dateInfo)

                self.updateDateLabelCell()
            }
            
            datePickerCell.configure(onDateChangedHandler: dateChangedHandler)
            resultCell = datePickerCell
        }
        
        return resultCell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(indexPath.section == 1 && indexPath.row == 1){
            
            if(!datePickerIsShown){
                datePickerIsShown = !datePickerIsShown
                insertDatePickerCellBelow(indexPath: indexPath)
            }
            else {
                datePickerIsShown = !datePickerIsShown
                deleteDatePickerCellBelow(indexPath: indexPath)
            }
        }
    }
    
 
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag == 0){
            addButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let textFromTextField = textField.text else {
            os_log("Text could not be retrieved from UITextField.")
            return
        }
        let eventText = EventInfo.text(textFromTextField)
        updateEventAndArray(eventInfo: eventText, textTag: textField.tag)

        updateAddButtonState()
    }
    
    
    // MARK: - Private Methods
    
    private func saveEventToArray() {
        var resultEvent = [[EventInfo]] ()
        
        guard let title = self.event.title, let location = self.event.location, let allDay = self.event.allDay else {
            os_log("Event could not be converted into array")
            return
        }
        
        resultEvent += [[EventInfo.text(title), EventInfo.text(location)], [EventInfo.uiSwitch(allDay), EventInfo.date(self.event.date)]]
        
        if (datePickerIsShown){
            resultEvent[1].append(EventInfo.datePicker)
        }
       
        eventArray = resultEvent
    }
    
    private func updateAddButtonState() {
        let text = event.title ?? ""
        addButton.isEnabled = !text.isEmpty
    }
    
    private func insertDatePickerCellBelow(indexPath: IndexPath) {
        let indexPathForInsert = IndexPath(row: indexPath.row + 1, section: indexPath.section)
        
        self.eventArray[indexPath.section].append(EventInfo.datePicker)
        self.tableView.insertRows(at: [indexPathForInsert], with: .top)
    }
    
    private func deleteDatePickerCellBelow(indexPath: IndexPath) {
        let indexPathForDeletion = IndexPath(row: indexPath.row + 1, section: indexPath.section)

        self.eventArray[indexPath.section].removeLast()
        self.tableView.deleteRows(at: [indexPathForDeletion], with: .top)
    }
    
    private func updateEventAndArray(eventInfo: EventInfo, textTag: Int? = nil){
        switch eventInfo {
        case let EventInfo.text(text):
            if(textTag == 0){
                self.event.title = text
            } else {
                self.event.location = text
            }
            
        case let EventInfo.date(date):
            self.event.date = date
            
        case let EventInfo.uiSwitch(switchIsOn):
            self.event.allDay = switchIsOn
            
        default:
            os_log("Event property could not be updated.")
            return
        }
        
        saveEventToArray()
    }
    
    private func changeDateIfAllDaySwitchIsOn(date: Date) -> Date {
        var returnDate = date
        
        if (event.allDay!){
            returnDate = userCalendar.startOfDay(for: date)
        } 
        
        return returnDate
    }
    
    private func updateDateLabelCell(){
        if self.indexPathForDateLabelCell != nil {
            tableView.reloadRows(at: [self.indexPathForDateLabelCell!], with: .none)
        }
    }

}

private enum EventInfo{
    case text(String)
    case uiSwitch(Bool)
    case date(Date)
    case datePicker
}
