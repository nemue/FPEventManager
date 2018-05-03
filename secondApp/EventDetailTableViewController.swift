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

    private var event: Event = Event()
    private var indexPathForDateLabelCell: IndexPath?
    private var eventArray = [[EventInfo]]()
    private var datePickerIsShown = false
    
    // MARK: - ViewController Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViewModelArray()
        self.updateAddButtonState()
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
        return self.eventArray[section].count
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.eventArray[indexPath.section][indexPath.row] {
        case .title:
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: Constants.textCellIdentifier, for: indexPath) as? EventDetailTextCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailTextCell")
            }
            
            let textCellTag = EventInfo.title.rawValue
            
            textCell.configure(textFieldDelegate: self, text: self.event.title, tag: textCellTag)
            return textCell
            
        case .location:
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: Constants.textCellIdentifier, for: indexPath) as? EventDetailTextCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailTextCell")
            }
            
            let textCellTag = EventInfo.location.rawValue
            
            textCell.configure(textFieldDelegate: self, text: self.event.location, tag: textCellTag)
            return textCell
            
        case .uiSwitch:
            guard let switchCell = tableView.dequeueReusableCell(withIdentifier: Constants.allDaySwitchCellIdentifier, for: indexPath) as? EventDetailAlldaySwitchCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailAlldaySwitchCell")
            }
            
            switchCell.configure(switchIsOn: (self.event.allDay ?? false), onSwitchValueChangedHandler: {(isSwitchOn: Bool) in
                self.event.allDay = isSwitchOn
                self.event.date = self.changeDateIfAllDaySwitchIsOn(date: self.event.date)
                self.updateDateLabelCell()
                self.updateViewModelArray()
            })
            return switchCell
            
        case .date:
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: Constants.dateCellIdentifier, for: indexPath) as? EventDetailDateCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailTextCell")
            }
            
            indexPathForDateLabelCell = indexPath
            
            dateCell.configure(showDate: event.date, isAllDayEvent: event.allDay ?? false)
            return dateCell
            
        case .datePicker:
            guard let datePickerCell = tableView.dequeueReusableCell(withIdentifier: Constants.datePickerCellIdentifier, for: indexPath) as? EventDetailDatePickerCell
                else {
                    fatalError("The dequeued cell is not an instance of EventDetailDatePickerCell")
                }
            
            let dateChangedHandler = { (newDate: Date) in
                let date = self.changeDateIfAllDaySwitchIsOn(date: newDate)
                
                self.event.date = date
                self.updateDateLabelCell()
            }
            
            datePickerCell.configure(onDateChangedHandler: dateChangedHandler)
            return datePickerCell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.eventArray[indexPath.section][indexPath.row] == .date {
            
            if(!self.datePickerIsShown){
                self.insertDatePickerCellBelow(indexPath: indexPath)
            }
            else {
                self.deleteDatePickerCellBelow(indexPath: indexPath)
            }
            
            self.datePickerIsShown = !self.datePickerIsShown
        }
    }
 
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateAddButtonState()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let eventInfo = EventInfo(rawValue: textField.tag) {
            switch eventInfo {
            case .title:
                self.event.title = textField.text
            case .location:
                self.event.location = textField.text
            default:
                os_log("Edited textField does not exist in textFieldDidEndEditing function.")
            }
        }

        self.updateAddButtonState()
    }
    
    // MARK: - Public Methods
    
    public func getEvent() -> Event {
        return self.event
    }
    
    // MARK: - Private Methods
    
    private func updateViewModelArray() {
        let firstSection: [EventInfo] = [.title, .location]
        var secondSection: [EventInfo] = [.uiSwitch, .date]
        
        if (datePickerIsShown) {
            secondSection.append(EventInfo.datePicker)
        }

        self.eventArray = [firstSection, secondSection]
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
    
    private func changeDateIfAllDaySwitchIsOn(date: Date) -> Date {
        var returnDate = date
        
        if (self.event.allDay!){
            returnDate = self.userCalendar.startOfDay(for: date)
        } 
        
        return returnDate
    }
    
    private func updateDateLabelCell(){
        if self.indexPathForDateLabelCell != nil {
            tableView.reloadRows(at: [self.indexPathForDateLabelCell!], with: .none)
        }
    }

}

// MARK: - Event-Enum

enum EventInfo: Int {
    case title = 0
    case location = 1
    case uiSwitch
    case date
    case datePicker
}
