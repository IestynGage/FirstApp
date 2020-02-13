//
//  databaseObjects.swift
//  ConferenceApp
//
//  Created by ieg4 on 14/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import Foundation

//Represents data for location in database
struct Location{
    var id: String
    var name: String
    var latitude: Double
    var longitude: Double
    var description: String
    
    // initialises the location with all the data
    init(id:String, name:String, latitude: Double, longitude: Double, description:String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
    }
    
    // All data into a string format
    func getString() -> String {
        return "ID: \(self.id),name: \(self.name),coords: ( \(self.latitude), \(self.longitude) ),desc: \(self.description)"
    }
}

// Represents data for session object in database
struct Session: Codable{
    var id: String
    var title: String
    var content: String
    var date: String
    var order:Int
    var timeStart: String
    var timeEnd: String
    var type: String
    
    var locationID: String  // Links to another object
    var speakerID: String   // Links to another object
    
    //initialises the session object with all the data
    init(id:String, title:String, content:String, date:String, order:Int, timeStart:String, timeEnd:String, type: String, locationID:String, speakerID:String){
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.order = order
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.type = type
        
        self.locationID = locationID
        self.speakerID = speakerID
    }
    //All Data in string format
    func getString() -> String{
    return "ID: \(self.id), title: \(self.title), content: \(self.content), date: \(self.date), order: \(self.order), timeStart: \(self.timeStart), timeEnd: \(self.timeEnd), type: \(self.type), locationID: \(self.locationID), speakerID: \(self.speakerID)"
    }
}

// Represents data for speaker object in database
struct Speaker{
    
    var id:         String
    var name:       String
    var biography:  String
    var twitter:    String
    
    //initialises the speaker object with all the data
    init(id:String, name:String, briography:String, twitter:String){
        self.id = id
        self.name = name
        self.biography = briography
        self.twitter = twitter
    }
    
    //initialises empty speaker
    init(){
        self.id = ""
        self.name = ""
        self.biography = ""
        self.twitter = ""
    }
    
    // All data in a string format
    func getString() -> String{
        return "ID: \(self.id), name: \(self.name), biography: \(self.biography), twitter: \(self.twitter)"
    }
}

// Represents filter options for searching for sessions.
class Filter{
    var sessionType:String
    var day:String
    
    //initialises the filter with all the data
    init(){
        self.sessionType = "Any"
        self.day = "Any"
    }
    
    //initialises the filter with search contain all data
    init(sessionType:String,day:String) {
        self.sessionType = sessionType
        self.day = day
    }
    
    //Gets session as an integer type
    //
    //Return:
    //      Int = the type of session
    func getSessionTypeAsInt() -> Int{
        switch(self.sessionType){
        case "Any":
            return 0
        case "Talk":
            return 1
        case "Workshop":
            return 2
        case "Food":
            return 3
        case "Register":
            return 4
        default:
            return 0
        }
    }
    
    // Gets day as an integer type
    //
    //Return:
    //      Int = the day of week as int
    func getDayAsInt() -> Int{
        switch(self.day){
        case "Any":
            return 0
        case "Day 1":
            return 1
        case "Day 2":
            return 2
        case "Day 3":
            return 3
        case "Day 4":
            return 4
        default:
            return 0
        }
    }
    
    //Gets day in format thats store on the database
    //
    //Return:
    //      String = the day of the week as calender day in format of YYYY-MM-DD
    func getDayAsDMY() -> String{
        switch(self.day){
        case "Day 1":
            return "2019-12-10"
        case "Day 2":
            return "2019-12-11"
        case "Day 3":
            return "2019-12-12"
        case "Day 4":
            return "2019-12-13"
        default:
            return ""
        }
    }
    
    //Get session type in format of query
    //
    //Return:
    //      String = in format needed to be recongised by SQL query
    func getSessionTypeQuery() -> String{
        if(sessionType=="Food"){
            return "coffee' OR sessionType = 'lunch' OR sessionType = 'dinner"
        } else if (sessionType=="Register"){
            return "registration"
        }
        return sessionType.lowercased()
    }
    
    //Generates WHERE query needed to find data when filter is applied
    //
    //Return:
    //      String = Filter in format needed to be recongised by SQL query
    func getQuery() -> String{
        if(sessionType != "Any" && day == "Any"){
            return "WHERE sessionType = '\(getSessionTypeQuery())'"
            
        } else if(sessionType == "Any" && day != "Any"){
            return "WHERE sessionDate = '\(self.getDayAsDMY())'"
            
        } else if(sessionType != "Any" && day != "Any"){
            return "WHERE sessionType = '\(getSessionTypeQuery())' AND sessionDate = '\(self.getDayAsDMY())'"
        }
        
        return ""
    }
    
    // Gets data of query in plain string format
    //
    //Return:
    //      String = Data of the filter.
    func getString() -> String{
        return "Session Type: \(self.sessionType), Day: \(self.day)"
    }
}
