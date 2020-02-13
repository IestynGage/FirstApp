//
//  ConferenceAppUITests.swift
//  ConferenceAppUITests
//
//  Created by ieg4 on 29/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import XCTest

class ConferenceAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSpeakerTab() {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Speakers"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Adam Rush"]/*[[".cells.staticTexts[\"Adam Rush\"]",".staticTexts[\"Adam Rush\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //rint(app.staticTexts["Adam Rush"].)
        //XCTAssertEqual(nameLabel, "Adam Rush")

        let speakersButton = app.navigationBars["ConferenceApp.SpeakerDetailsVC"].buttons["Speakers"]
        speakersButton.tap()

        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Steven Gray"]/*[[".cells.staticTexts[\"Steven Gray\"]",".staticTexts[\"Steven Gray\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        speakersButton.tap()
   
       
    }
    
    func testTabNavigation(){
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Agenda"].tap()
        app.tabBars.buttons["Map"].tap()
        app.tabBars.buttons["Speakers"].tap()
        app.tabBars.buttons["Favourites"].tap()

    }
    
    func testAgendaTab(){
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Agenda"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Welcome / Introduction"]/*[[".cells.staticTexts[\"Welcome \/ Introduction\"]",".staticTexts[\"Welcome \/ Introduction\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testLocation(){
        
        let app = XCUIApplication()
        app.tabBars.buttons["Agenda"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["I'll tell you what you can do with Core ML"]/*[[".cells.staticTexts[\"I'll tell you what you can do with Core ML\"]",".staticTexts[\"I'll tell you what you can do with Core ML\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Physics Main"]/*[[".scrollViews.buttons[\"Physics Main\"]",".buttons[\"Physics Main\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
}
