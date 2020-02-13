//
//  FilterVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 30/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit

// This class is used to create filter object from UI Controller.
//
// Requires the segue onto the controller to load a filter.
//
class FilterVC: UIViewController {
    
    //UI Objects
        //Segment
    @IBOutlet weak var lectureTypeSegment: UISegmentedControl!  // Segment of the lecture type
    @IBOutlet weak var daySegment: UISegmentedControl!  // Segment of day type
    
    //Objects
    var filter:Filter! // the filter that will be edited in the controller.
    
    //
    // This method loads the currect selected filter items onto the segments UI.
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lectureTypeSegment.selectedSegmentIndex =  filter.getSessionTypeAsInt()
        daySegment.selectedSegmentIndex =  filter.getDayAsInt()
    }
    
    // This sets the filter objects with current selected lecture on UI segment.
    //
    //Parameters:
    //    sender = The UI object that sent the request to execute the function
    //
    @IBAction func setLectureType(_ sender: UISegmentedControl) {
        filter.sessionType = lectureTypeSegment.titleForSegment(at:lectureTypeSegment.selectedSegmentIndex) ?? "Error"
        #if DEBUG
        if(filter.sessionType == "Error"){
            print("FilterVC DEBUG: Couldn't load selected Segment for lectureTypeSegment")
        }
        #endif
    }
    
    
     //This sets the filter objects with current selected lecture on UI segment.
     //
     //Parameters:
     //   sender = The UI object that sent the request to execute the function
     //
    @IBAction func setDay(_ sender: UISegmentedControl) {
        filter.day = daySegment.titleForSegment(at:daySegment.selectedSegmentIndex) ?? "Error"
        #if DEBUG
        if(filter.day == "Error"){
            print("FilterVC DEBUG: Couldn't load selected Segment for daySegment")
        }
        #endif
    }
    
}
