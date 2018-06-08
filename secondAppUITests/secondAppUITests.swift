//
//  secondAppUITests.swift
//  secondAppUITests
//
//  Created by Nele Müller on 05.06.18.
//  Copyright © 2018 Nele Müller. All rights reserved.
//

import XCTest
@testable import secondApp

class secondAppUITests: XCTestCase {
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launch()
    }
    
    func testAddAllDayEvent() {
        self.setUpForDetailViewTest()
        
        // When:
        
        let switchValueAsString = testAddEvent(allDayEvent: true)
        
        // Then:
        
        XCTAssertEqual(app.tables.cells.count, 1)
        XCTAssertTrue(switchValueAsString == "1")
    }
    
    func testNotAllDayEvent() {
        self.setUpForDetailViewTest()
        
        // When:
        
        let switchValueAsString = testAddEvent()
        
        // Then:
        
        XCTAssertTrue(switchValueAsString == "0")
    }
    
    func testDatePicker() {
        
        self.setUpForDetailViewTest()
        
        // Given:
        
        let dayAndMonthForPicker = "Apr 18"
        let hourForPicker = "8"
        let minutesForPicker = "00"
        let currentYear = Calendar.current.component(.year, from: Date())
        let compareStringDate = "Starts, 18.04." + String(describing: currentYear) + " 0" + hourForPicker + ":" + minutesForPicker
        
        let datePicker = app.tables.cells["detailDatePickerCellId"].pickerWheels
        let dateCell = app.tables.cells["detailDateCellId"]
        
        // When:
        
        dateCell.tap()
        datePicker.element(boundBy: 0).adjust(toPickerWheelValue: dayAndMonthForPicker)
        datePicker.element(boundBy: 1).adjust(toPickerWheelValue: hourForPicker)
        datePicker.element(boundBy: 2).adjust(toPickerWheelValue: minutesForPicker)
        
        // Then:
        
        let dateLabelText = app.tables.cells["detailDateCellId"].label
        XCTAssert(dateLabelText == compareStringDate)
    }
}

 // MARK: - Private Methods

extension secondAppUITests {
    
    private func setUpForDetailViewTest() {
        app.navigationBars["Events"].buttons["Add"].tap()
    }
    
    private func testAddEvent (allDayEvent: Bool? = false) -> String {
        
        // Given:
        
        let tablesQuery = app.tables
        let titleTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Title"]/*[[".cells.textFields[\"Title\"]",".textFields[\"Title\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let addButtonInEventDetail = app.navigationBars["New Event"].buttons["Add"]
        let allDaySwitchInDetailView = tablesQuery.switches["detailAllDaySwitchId"]

        // When:
        
        titleTextField.tap()
        titleTextField.typeText("Event 1")

        if allDayEvent! {
            allDaySwitchInDetailView.tap()
        }

        addButtonInEventDetail.tap()
        
        // Then:
        XCTAssertEqual(app.tables.cells.count, 1)
        XCTAssert(tablesQuery.cells.element.label.contains("Event 1"))

        let allDaySwitchInList = tablesQuery.switches["allDaySwitchId"]
        let switchInListValueAsString = (allDaySwitchInList.value as? String) ?? ""
        return switchInListValueAsString
    }
}
