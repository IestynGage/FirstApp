//
//  SessionTVCell.swift
//  ConferenceApp
//
//  Created by ieg4 on 19/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit

//
// Links objects to display Session data in cell
// Requires the data to be set in another controller
class SessionTVCell: UITableViewCell {

    // UI Objects
        //Labels
    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var speaker: UILabel!
        // View
    @IBOutlet weak var sessionTypeColor: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Sets the Cell UI objects with data read from displaySession
    //
    //Parameters:
    //      displaySession = Session you want to be displayed in cell
    //
    func setDisplayData(displaySession:Session){
        sessionTitle.text = displaySession.title
        startTime.text = displaySession.timeStart
        
        if(displaySession.type == "talk"){
            sessionTypeColor.layer.backgroundColor = UIColor.green.cgColor
        } else if ( displaySession.type == "workshop"){
            sessionTypeColor.layer.backgroundColor = UIColor.purple.cgColor
        } else if (displaySession.type == "coffee" || displaySession.type == "lunch" || displaySession.type == "dinner"){
            sessionTypeColor.layer.backgroundColor = UIColor.yellow.cgColor
        } else if ( displaySession.type == "registration"){
            sessionTypeColor.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        
        if(displaySession.speakerID != ""){
            speaker.text = DBAccess.sharedInstance.getSpeaker(displaySession.speakerID).name
        } else {
            speaker.text = ""
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
