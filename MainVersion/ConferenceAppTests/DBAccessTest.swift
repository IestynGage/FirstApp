//
//  ConferenceAppTests.swift
//  ConferenceAppTests
//
//  Created by ieg4 on 19/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import XCTest

class DBAccessTest: XCTestCase {

    override func setUp() {
        let empty:[Session] = []
        DBAccess.sharedInstance.saveFavouritesList(favList: empty)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetSpeaker(){
        let actual1:String = DBAccess.sharedInstance.getSpeaker("AdamRush").getString()
        let actual2:String = DBAccess.sharedInstance.getSpeaker("AgnieszkaCzyzak").getString()
        let actual3:String = DBAccess.sharedInstance.getSpeaker("AlanMorris").getString()
        
        let expected1:String = "ID: AdamRush, name: Adam Rush, biography: Adam Rush is a passionate iOS developer with over 6 years commercial experience, contracting all over the UK & Europe. He's a tech addict and #Swift enthusiast., twitter: adam9rush"
        
        let expected2:String = "ID: AgnieszkaCzyzak, name: Agnieszka  Czyak, biography: Agnieszka is a UX designer at Polidea., twitter: agaczyzak"
            
        let expected3:String = "ID: AlanMorris, name: Alan Morris, biography: With over 16 years in the tech and development industry, for organisations such as Orange and Accenture, Alan ran a successful iOS development agency before joining hedgehog lab to lead the development team., twitter: dippigu"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
    
    func testGetFirstSpeakers(){
        let speakers:[Speaker] = DBAccess.sharedInstance.getSpeakers()
        let actual1:String = speakers[0].getString()
        let actual2:String = speakers[1].getString()
        let actual3:String = speakers[2].getString()
        
        let expected1:String = "ID: AdamRush, name: Adam Rush, biography: Adam Rush is a passionate iOS developer with over 6 years commercial experience, contracting all over the UK & Europe. He's a tech addict and #Swift enthusiast., twitter: adam9rush"
        
        let expected2:String = "ID: AgnieszkaCzyzak, name: Agnieszka  Czyak, biography: Agnieszka is a UX designer at Polidea., twitter: agaczyzak"
        
        let expected3:String = "ID: AlanMorris, name: Alan Morris, biography: With over 16 years in the tech and development industry, for organisations such as Orange and Accenture, Alan ran a successful iOS development agency before joining hedgehog lab to lead the development team., twitter: dippigu"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
        
    }
    
    func testGetLastSpeakers(){
        let speakers:[Speaker] = DBAccess.sharedInstance.getSpeakers()
        let actual1:String = speakers[18].getString()
        let actual2:String = speakers[19].getString()
        let actual3:String = speakers[20].getString()
        
        print(actual1)
        print(actual2)
        print(actual3)
        let expected1:String = "ID: ElviroRocca, name: Elviro Rocca, biography: Elviro worked for some years as a Materials Engineer before focusing on his true passion: functional programming. He is the lead iOS Developer at Facile.it, twitter: _logicist"
        
        let expected2:String = "ID: SashZats, name: Sash Zats, biography: Sash Zats is a designer and generative artist building toools for designers at Facebook. , twitter: zats"
        
        let expected3:String = "ID: StevenGray, name: Steven Gray, biography: Steven works in Oregon for SoftSource Consulting., twitter: sgray_sftsrc"
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
        
    }
    
    func testGetSession(){
        let actual1:String = DBAccess.sharedInstance.getSession(sessionID: "arkit").getString()
        let actual2:String = DBAccess.sharedInstance.getSession(sessionID: "coffee3").getString()
        let actual3:String = DBAccess.sharedInstance.getSession(sessionID: "hack").getString()
        
        let expected1 = Session.init(id: "arkit", title: "Using ARKit with SpriteKit", content: "ARKit is the hot new framework announced at WWDC 2017. This workshop will get your feet wet so that you can create the augmented reality application of your dreams. ", date: "2019-12-10", order: 0, timeStart: "16:00", timeEnd: "18:00", type: "workshop", locationID: "b23", speakerID: "JanieClayton").getString()
        
        let expected2 = Session.init(id: "coffee3", title: "Coffee Break", content: "Coffee and cakes available in the Physics Foyer. ", date: "2019-12-12", order: 2, timeStart: "10:40", timeEnd: "11:20", type: "coffee", locationID: "foyer", speakerID: "").getString()
        
        let expected3 = Session.init(id: "hack", title: "ARKit hack", content: "This hack session will have the challenge of building a working Apple Watch game.", date: "2019-12-13", order: 6, timeStart: "13:30", timeEnd: "23:30", type: "workshop", locationID: "b23", speakerID: "").getString()
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
    
    func testGetFirstSessions(){
        let sessions:[Session] = DBAccess.sharedInstance.getSessions(filter: Filter.init())
        let actual1:String = sessions[0].getString()
        let actual2:String = sessions[1].getString()
        let actual3:String = sessions[2].getString()
        
        let expected1:String = "ID: arkit, title: Using ARKit with SpriteKit, content: ARKit is the hot new framework announced at WWDC 2017. This workshop will get your feet wet so that you can create the augmented reality application of your dreams. , date: 2019-12-10, order: 0, timeStart: 16:00, timeEnd: 18:00, type: workshop, locationID: b23, speakerID: JanieClayton"
        
        let expected2:String = "ID: spoons, title: Optional Social, content: Come to Yr Hen Orsaf (local Wetherspoons) when you arrive in Aber, and meet some other delegates. If you are coming to Aber by train, it is easy to find - it's part of the railway station., date: 2019-12-10, order: 1, timeStart: 18:00, timeEnd: 23:59, type: dinner, locationID: spoons, speakerID: "
        
        let expected3:String = "ID: registration, title: Registration, content: Collect your badge and registration goodies,., date: 2019-12-11, order: 0, timeStart: 09:00, timeEnd: 09:30, type: registration, locationID: foyer, speakerID: "
            
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
    
    func testGetLastSessions(){
        let sessions:[Session] = DBAccess.sharedInstance.getSessions(filter: Filter.init())
        let actual1:String = sessions[31].getString()
        let actual2:String = sessions[32].getString()
        let actual3:String = sessions[33].getString()
        
        let expected1:String = "ID: ibawesome, title: Interface Builder considered awesome, content: Storyboards and XIBs create horrible merge-conficts in teams, are unreviewable in Pull-Requests and they don't even support comments. So no responsible developer in a team should ever be using Interface Builder for a serious iOS project, right?, date: 2019-12-13, order: 4, timeStart: 11:20, timeEnd: 12:00, type: talk, locationID: physmain, speakerID: JoachimKurz"
        
        let expected2:String = "ID: havoc, title: Cry 'Havoc!' and let slip the dogs of software, content: Scotty explores the wonder of the software industry, date: 2019-12-13, order: 5, timeStart: 12:00, timeEnd: 12:40, type: talk, locationID: physmain, speakerID: SteveScott"
        
        let expected3:String = "ID: hack, title: ARKit hack, content: This hack session will have the challenge of building a working Apple Watch game., date: 2019-12-13, order: 6, timeStart: 13:30, timeEnd: 23:30, type: workshop, locationID: b23, speakerID: "
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
    
    func testGetLocation(){
        let actual1:String = DBAccess.sharedInstance.getLocation(locationID: "b23").getString()
        let actual2:String = DBAccess.sharedInstance.getLocation(locationID: "foyer").getString()
        let actual3:String = DBAccess.sharedInstance.getLocation(locationID: "medrus").getString()
        
        let expected1:String = "ID: b23,name: Llandinam B23,coords: ( 52.416367, -4.066299 ),desc: The Hack on Thursday afternoon and evening will be run in this workroom."
        
        let expected2:String = "ID: foyer,name: Physics Foyer,coords: ( 52.415941, -4.065818 ),desc: This is the location for the refreshments provided during the conference."
        
        let expected3:String = "ID: medrus,name: Medrus Mawr,coords: ( 52.417941, -4.064823 ),desc: The conference meal will be in Medrus, which is in the Penbryn building, close to the main entrance to campus."

        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
    
    func testGetAllLocation(){
        let locations:[Location] = DBAccess.sharedInstance.getAllLocation()
        let actual1:String = locations[0].getString()
        let actual2:String = locations[2].getString()
        let actual3:String = locations[5].getString()
        
        let expected1:String = "ID: b23,name: Llandinam B23,coords: ( 52.416367, -4.066299 ),desc: The Hack on Thursday afternoon and evening will be run in this workroom."
        
        let expected2:String = "ID: foyer,name: Physics Foyer,coords: ( 52.415941, -4.065818 ),desc: This is the location for the refreshments provided during the conference."
        
        let expected3:String = "ID: medrus,name: Medrus Mawr,coords: ( 52.417941, -4.064823 ),desc: The conference meal will be in Medrus, which is in the Penbryn building, close to the main entrance to campus."
        
        XCTAssert(actual1 == expected1)
        XCTAssert(actual2 == expected2)
        XCTAssert(actual3 == expected3)
    }
 
    func testSaveLoadFavList(){

        let toBeAdded1:Session = Session.init(id: "arkit", title: "Using ARKit with SpriteKit", content: "ARKit is the hot new framework announced at WWDC 2017. This workshop will get your feet wet so that you can create the augmented reality application of your dreams. ", date: "2019-12-10", order: 0, timeStart: "16:00", timeEnd: "18:00", type: "workshop", locationID: "b23", speakerID: "JanieClayton")
        
        let toBeAdded2:Session = Session.init(id: "coffee3", title: "Coffee Break", content: "Coffee and cakes available in the Physics Foyer. ", date: "2019-12-12", order: 2, timeStart: "10:40", timeEnd: "11:20", type: "coffee", locationID: "foyer", speakerID: "")
        
        let toBeAdded3:Session = Session.init(id: "hack", title: "ARKit hack", content: "This hack session will have the challenge of building a working Apple Watch game.", date: "2019-12-13", order: 6, timeStart: "13:30", timeEnd: "23:30", type: "workshop", locationID: "b23", speakerID: "")
        
        let expected1:[Session] = [toBeAdded1,toBeAdded2,toBeAdded3]
        
        DBAccess.sharedInstance.saveFavouritesList(favList: expected1)
        let actual1:[Session] = DBAccess.sharedInstance.loadFavouriteSessionList()
        
        let expected2:[Session] = []
        DBAccess.sharedInstance.saveFavouritesList(favList: expected2)
        let actual2:[Session] = DBAccess.sharedInstance.loadFavouriteSessionList()

        XCTAssert(actual1[0].getString()==expected1[0].getString())
        XCTAssert(actual1[1].getString()==expected1[1].getString())
        XCTAssert(actual1[2].getString()==expected1[2].getString())
        
        XCTAssert(actual2.isEmpty)
     }
 

    func testAddSession(){
        let toBeAdded1:Session = Session.init(id: "arkit", title: "Using ARKit with SpriteKit", content: "ARKit is the hot new framework announced at WWDC 2017. This workshop will get your feet wet so that you can create the augmented reality application of your dreams. ", date: "2019-12-10", order: 0, timeStart: "16:00", timeEnd: "18:00", type: "workshop", locationID: "b23", speakerID: "JanieClayton")
        DBAccess.sharedInstance.addFavouriteSession(favSession: toBeAdded1)
        
        let toBeAdded2:Session = Session.init(id: "coffee3", title: "Coffee Break", content: "Coffee and cakes available in the Physics Foyer. ", date: "2019-12-12", order: 2, timeStart: "10:40", timeEnd: "11:20", type: "coffee", locationID: "foyer", speakerID: "")
        DBAccess.sharedInstance.addFavouriteSession(favSession: toBeAdded2)
        
        let toBeAdded3:Session = Session.init(id: "hack", title: "ARKit hack", content: "This hack session will have the challenge of building a working Apple Watch game.", date: "2019-12-13", order: 6, timeStart: "13:30", timeEnd: "23:30", type: "workshop", locationID: "b23", speakerID: "")
        DBAccess.sharedInstance.addFavouriteSession(favSession: toBeAdded3)
        
        let expected1:[Session] = [toBeAdded1,toBeAdded2,toBeAdded3]
        
        let actual1 = DBAccess.sharedInstance.loadFavouriteSessionList()
        
        XCTAssert(actual1[0].getString()==expected1[0].getString())
        XCTAssert(actual1[1].getString()==expected1[1].getString())
        XCTAssert(actual1[2].getString()==expected1[2].getString())
    }
    
    func testRemoveSession(){
        let toBeAdded1:Session = Session.init(id: "arkit", title: "Using ARKit with SpriteKit", content: "ARKit is the hot new framework announced at WWDC 2017. This workshop will get your feet wet so that you can create the augmented reality application of your dreams. ", date: "2019-12-10", order: 0, timeStart: "16:00", timeEnd: "18:00", type: "workshop", locationID: "b23", speakerID: "JanieClayton")
        DBAccess.sharedInstance.addFavouriteSession(favSession: toBeAdded1)
        
        let toBeAdded2:Session = Session.init(id: "coffee3", title: "Coffee Break", content: "Coffee and cakes available in the Physics Foyer. ", date: "2019-12-12", order: 2, timeStart: "10:40", timeEnd: "11:20", type: "coffee", locationID: "foyer", speakerID: "")
        DBAccess.sharedInstance.addFavouriteSession(favSession: toBeAdded2)
        
        let toBeRomoved:Session = Session.init(id: "hack", title: "ARKit hack", content: "This hack session will have the challenge of building a working Apple Watch game.", date: "2019-12-13", order: 6, timeStart: "13:30", timeEnd: "23:30", type: "workshop", locationID: "b23", speakerID: "")
        DBAccess.sharedInstance.addFavouriteSession(favSession: toBeRomoved)
        
        DBAccess.sharedInstance.removeFavouriteSession(favSession: toBeRomoved)
        let expected1:[Session] = [toBeAdded1,toBeAdded2]
        
        let actual1 = DBAccess.sharedInstance.loadFavouriteSessionList()
        
        XCTAssert(actual1[0].getString()==expected1[0].getString())
        XCTAssert(actual1[1].getString()==expected1[1].getString())
        XCTAssert(actual1.count==2)
    }
    
    func testIsFavouriteSession(){
        let actual1:Session = Session.init(id: "arkit", title: "Using ARKit with SpriteKit", content: "ARKit is the hot new framework announced at WWDC 2017. This workshop will get your feet wet so that you can create the augmented reality application of your dreams. ", date: "2019-12-10", order: 0, timeStart: "16:00", timeEnd: "18:00", type: "workshop", locationID: "b23", speakerID: "JanieClayton")
        DBAccess.sharedInstance.addFavouriteSession(favSession: actual1)
        
        let actual2:Session = Session.init(id: "hack", title: "ARKit hack", content: "This hack session will have the challenge of building a working Apple Watch game.", date: "2019-12-13", order: 6, timeStart: "13:30", timeEnd: "23:30", type: "workshop", locationID: "b23", speakerID: "")
        
        XCTAssert(DBAccess.sharedInstance.isFavouriteSession(session: actual1))
        XCTAssert((DBAccess.sharedInstance.isFavouriteSession(session: actual2) == false))
        
    }
    
}
