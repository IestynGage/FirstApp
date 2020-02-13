//
//  DBAccess.swift
//  ConferenceApp
//
//  Created by ieg4 on 14/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import Foundation
import SQLite3

private let _hiddenSharedInstance = DBAccess()

//Contains all methods to read data and write data onto the device
class DBAccess{

    class var sharedInstance: DBAccess{
        return _hiddenSharedInstance;
    }
    
    var mySQLDB: OpaquePointer? = nil  // This is a pointer to the database
    
    init(){
        openSQLDB()
    }
    
    // Opens up the database file
    func openSQLDB(){
        //Set up path to DB, and open
        let bundle = Bundle.main
        guard let defaultDBPath = bundle.path( forResource: "conf", ofType: "sqlite3")
            else {
                assertionFailure( "Couldn't find database path")
                return
        }
        guard sqlite3_open_v2( defaultDBPath, &mySQLDB, SQLITE_OPEN_READONLY, nil) == SQLITE_OK
            else {
                assertionFailure( "Couldn't open database")
                return
        }
    }
    
    //Gets a string from sql query
    //
    //Parameters:
    //      OpaquePointer = the SQL query
    //      fieldIndex = the location in query where the return string is
    //
    // Return:
    //      answer = The String in query at
    func stringAtField(_ statementPointer: OpaquePointer, fieldIndex: Int ) -> String {
        var answer = "Error - DBAccess failed"
        if let rawString = sqlite3_column_text(statementPointer, Int32(fieldIndex) ) {
            answer = String(cString: rawString)
        }
        
        return answer
    }
    
    //This gets a specified speaker using ID
    //
    //
    //Parameters:
    //      speakerID = the speacker you which to get
    //
    // Return:
    //      speaker = the speaker object with data of speaker with same ID as speakerID
    //
    func getSpeaker(_ speakerID: String) -> Speaker {
        var speaker: Speaker!

        // Selects a speaker's name, biography, twitter data from Speaker databases
        let query = "SELECT name, biography, twitter FROM speakers WHERE id = '\(speakerID)';"
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let speakerName = stringAtField(statement!, fieldIndex: 0)
                let speakerBriography = stringAtField(statement!, fieldIndex: 1)
                let speakerTwitter = stringAtField(statement!, fieldIndex: 2)
                
                speaker = Speaker.init(id: speakerID, name: speakerName, briography: speakerBriography, twitter: speakerTwitter)
            }
            
        }
        sqlite3_finalize(statement)
        return speaker;
    }
    
    // Gets an aray of speakers from the database
    //
    //
    // Return:
    //      speakers = array of all speakers
    //
    func getSpeakers() -> [Speaker] {
        var speakers:[Speaker] = []

        let query = "SELECT id,name, biography, twitter FROM speakers;"
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let speakerID = stringAtField(statement!, fieldIndex: 0)
                let speakerName = stringAtField(statement!, fieldIndex: 1)
                let speakerBriography = stringAtField(statement!, fieldIndex: 2)
                let speakerTwitter = stringAtField(statement!, fieldIndex: 3)
                
                let speaker = Speaker.init(id: speakerID, name: speakerName, briography: speakerBriography, twitter: speakerTwitter)
                
                speakers.append(speaker)
            }
            
        }
        sqlite3_finalize(statement)
        return speakers;
    }
    
    // Gets a specific Session fobject from the database
    //
    //Parameters:
    //      sessionID = ID of the session you want to get
    //
    // Return:
    //      session = session object with data with session with the same ID
    //
    func getSession(sessionID:String) -> Session{
        var session:Session!
        
        let query = "SELECT title, content, sessionDate, sessionOrder, timeStart, timeEnd, sessionType, locationId, speakerId FROM sessions WHERE id = '\(sessionID)' ORDER BY sessionDate, sessionOrder;"
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let title = stringAtField(statement!, fieldIndex: 0)
                let content = stringAtField(statement!, fieldIndex: 1)
                let date = stringAtField(statement!, fieldIndex: 2)
                let order = Int(sqlite3_column_int(statement,3))
                let timeStart = stringAtField(statement!, fieldIndex: 4)
                let timeEnd = stringAtField(statement!, fieldIndex: 5)
                let type = stringAtField(statement!, fieldIndex: 6)
                let locationID = stringAtField(statement!, fieldIndex: 7)
                let speakerID = stringAtField(statement!, fieldIndex: 8)
                
                session = Session.init(id: sessionID, title: title, content: content, date: date, order: order, timeStart: timeStart, timeEnd: timeEnd, type: type, locationID: locationID, speakerID: speakerID)
            }
            
        }
        sqlite3_finalize(statement)
        return session;
    }
    
    // Gets all Sessions from the database
    //
    //
    // Return:
    //      sessions = array of all sessions from database
    //
    func getSessions(filter:Filter) -> [Session] {
        var sessions:[Session] = []
        
        let query = "SELECT id,title, content, sessionDate, sessionOrder, timeStart, timeEnd, sessionType, locationId, speakerId FROM sessions \(filter.getQuery()) ORDER BY sessionDate,sessionOrder;"
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let sessionID = stringAtField(statement!, fieldIndex: 0)
                let title = stringAtField(statement!, fieldIndex: 1)
                let content = stringAtField(statement!, fieldIndex: 2)
                let date = stringAtField(statement!, fieldIndex: 3)
                let order = Int(sqlite3_column_int(statement,4))
                let timeStart = stringAtField(statement!, fieldIndex: 5)
                let timeEnd = stringAtField(statement!, fieldIndex: 6)
                let type = stringAtField(statement!, fieldIndex: 7)
                let locationID = stringAtField(statement!, fieldIndex: 8)
                let speakerID = stringAtField(statement!, fieldIndex: 9)
                
                let session = Session.init(id: sessionID, title: title, content: content, date: date, order: order, timeStart: timeStart, timeEnd: timeEnd, type: type, locationID: locationID, speakerID: speakerID)
                
                sessions.append(session)
            }
            
        }
        sqlite3_finalize(statement)
        return sessions;
    }
    
    // Gets specific location object from database with locationID
    //
    //Parameters:
    //      locationID = The ID of location that gets read
    //
    // Return:
    //      location = the location object with the same locationID in database
    //
    func getLocation(locationID:String) -> Location {
        var location:Location!
        
        let query = "SELECT name, latitude, longitude, description FROM locations WHERE id = '\(locationID)';"
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                let name = stringAtField(statement!, fieldIndex: 0)
                let latitude = sqlite3_column_double(statement,1)
                let longitude = sqlite3_column_double(statement,2)
                let description = stringAtField(statement!, fieldIndex: 3)
                
                location = Location.init(id: locationID, name: name, latitude: latitude, longitude: longitude, description: description)
            }
            
        }
        sqlite3_finalize(statement)
        return location;
    }
    
    //Gets all location objects that are in database
    //
    //
    // Return:
    //      location = array of all locations in the database
    //
    func getAllLocation() -> [Location] {
        var location:[Location] = []
        
        let query = "SELECT id, name, latitude, longitude, description FROM locations;"
        
        var statement: OpaquePointer? = nil  // Pointer for sql to track returns
        
        if sqlite3_prepare_v2( mySQLDB, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = stringAtField(statement!, fieldIndex: 0)
                let name = stringAtField(statement!, fieldIndex: 1)
                let latitude = sqlite3_column_double(statement,2)
                let longitude = sqlite3_column_double(statement,3)
                let description = stringAtField(statement!, fieldIndex: 4)
                
                location.append(Location.init(id:id, name: name, latitude: latitude, longitude: longitude, description: description))
            }
            
        }
        sqlite3_finalize(statement)
        return location;
    }
    
    //Encodes a list of sessions into PropertyList. Saves PropertyList onto device.
    //Should not be used outside of this class.
    //Parameters:
    //      favList = The array of sessions to be saved onto the device
    //
    func saveFavouritesList(favList:[Session]){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("fav").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        let encodeNote = try? propertyListEncoder.encode(favList)
        
        try? encodeNote?.write(to: archiveURL, options: .noFileProtection)
    }
    
    // Loads PropertyList from device and decodes it into array of sessions.
    // Should not be used outside of this class
    // Return:
    //      array of sessions that were saved onto the device
    //
    func loadFavouriteSessionList() -> [Session]{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let archiveURL = documentsDirectory.appendingPathComponent("fav").appendingPathExtension("plist")
        
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedNotesData = try? Data(contentsOf: archiveURL),let decodedNotes = try? propertyListDecoder.decode(Array<Session>.self, from: retrievedNotesData){
                return decodedNotes
        }
            return []
    }
    
    //Saves a sessions onto permenant storage
    //
    //Parameters:
    //  favSession = favourite Session to be saved
    //
    func addFavouriteSession(favSession:Session){
        var favSessionList:[Session] = DBAccess.sharedInstance.loadFavouriteSessionList()
        favSessionList.append(favSession)
        DBAccess.sharedInstance.saveFavouritesList(favList: favSessionList)
    }
    
    //Removes a specific session from permenant storage
    //
    //Parameters:
    //  favSession = session to be removed
    //
    func removeFavouriteSession(favSession:Session){
        var favSessionList:[Session] = DBAccess.sharedInstance.loadFavouriteSessionList()
        
        if let itemToRemove = favSessionList.firstIndex(where: {$0.id == favSession.id}){
            favSessionList.remove(at: itemToRemove)
        DBAccess.sharedInstance.saveFavouritesList(favList: favSessionList)
        }
    }
    
    // Checks if specific session is in permenant storage on the device.
    //
    //Parameters:
    //      session = session to be searched for in permenant storage
    // Return:
    //      Bool = true if specific session is in permenet storage else false
    //
    func isFavouriteSession(session:Session) -> Bool {
        let favSessionList:[Session] = DBAccess.sharedInstance.loadFavouriteSessionList()
    
        if favSessionList.firstIndex(where: {$0.id == session.id}) != nil{ return true}
        
        return false
    }
    
}
