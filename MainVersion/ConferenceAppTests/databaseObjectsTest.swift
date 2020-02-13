//
//  databaseObjectsTest.swift
//  ConferenceAppTests
//
//  Created by ieg4 on 02/12/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import XCTest

class DatabaseObjectsTest: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testLocationGetString(){
        let actual1 = Location(id: "someID", name: "Earth", latitude: 1.01, longitude: 1.01, description: "The planet with all the humans").getString()
        let expected1 = "ID: someID,name: Earth,coords: ( 1.01, 1.01 ),desc: The planet with all the humans"
        print(actual1)
        XCTAssert(actual1 == expected1)
    }

    func testSessionGetString(){
        let actual1 = Session(id: "sessionID", title: "The Session!", content: "Some Session about the /session/", date: "The future ofcourse!", order: 5, timeStart: "13:20", timeEnd: "15:50", type: "talk", locationID: "Space", speakerID: "Mr.ET").getString()
        
        let expected1 = "ID: sessionID, title: The Session!, content: Some Session about the /session/, date: The future ofcourse!, order: 5, timeStart: 13:20, timeEnd: 15:50, type: talk, locationID: Space, speakerID: Mr.ET"
        
        XCTAssert(actual1 == expected1)
    }

    func testSpeakerGetString(){
        let actual1 = Speaker(id: "theID", name: "Mr Fancy Pants", briography: "Mr Fancy Pants wears very Fancy Pants!", twitter: "something").getString()
        let expected1 = "ID: theID, name: Mr Fancy Pants, biography: Mr Fancy Pants wears very Fancy Pants!, twitter: something"
        XCTAssert(actual1 == expected1)
    }
    
    func testFilterGetSessionTypeAsInt(){
        let actual1 = Filter(sessionType: "Any", day: "Any").getSessionTypeAsInt()
        let actual2 = Filter(sessionType: "Food", day: "Any").getSessionTypeAsInt()
        let expected1 = 0
        let expected2 = 3
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
    }
    
    func testFilterGetDayTypeAsInt(){
        let actual1 = Filter(sessionType: "Any", day: "Any").getDayAsInt()
        let actual2 = Filter(sessionType: "Any", day: "Day 2").getDayAsInt()
        let expected1 = 0
        let expected2 = 2
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
    }
    
    func testFilterGetDayTypeDMY(){
        let actual1 = Filter(sessionType: "Any", day: "Day 1").getDayAsDMY()
        let actual2 = Filter(sessionType: "Any", day: "Day 4").getDayAsDMY()
        let expected1 = "2019-12-10"
        let expected2 = "2019-12-13"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
    }
    func testFilterGetSessionTypeQuery(){
        let actual1 = Filter(sessionType: "Food", day: "Any").getSessionTypeQuery()
        let actual2 = Filter(sessionType: "Register", day: "Any").getSessionTypeQuery()
        let actual3 = Filter(sessionType: "Talk", day: "Any").getSessionTypeQuery()
        let expected1 = "coffee' OR sessionType = 'lunch' OR sessionType = 'dinner"
        let expected2 = "registration"
        let expected3 = "talk"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
    
    func testFilterGetQuery(){
        let actual1 = Filter(sessionType: "Register", day: "Any").getQuery()
        let actual2 = Filter(sessionType: "Any", day: "Any").getQuery()
        let actual3 = Filter(sessionType: "Any", day: "Day 1").getQuery()
        let actual4 = Filter(sessionType: "Food", day: "Day 3").getQuery()
        
        let expected1 = "WHERE sessionType = 'registration'"
        let expected2 = ""
        let expected3 = "WHERE sessionDate = '2019-12-10'"
        let expected4 = "WHERE sessionType = 'coffee' OR sessionType = 'lunch' OR sessionType = 'dinner' AND sessionDate = '2019-12-12'"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
        XCTAssert(actual4 == expected4)
    }
    
    func testFilterGetString(){
        let actual1 = Filter(sessionType: "Register", day: "Any").getString()
        let actual2 = Filter(sessionType: "Any", day: "Day 1").getString()
        
        let expected1 = "Session Type: Register, Day: Any"
        let expected2 = "Session Type: Any, Day: Day 1"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
    }
}
