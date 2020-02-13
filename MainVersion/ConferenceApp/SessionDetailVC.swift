//
//  SessionDetailVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 18/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit

//
//Sets the displays the session information,
//
//Requires the segue onto the controller to load a session.
//
class SessionDetailVC: UIViewController {

    // UI Objects
        // Labels
    @IBOutlet weak var sessionTitle: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var sessionType: UILabel!
    @IBOutlet weak var sessionDesc: UILabel!
    
    @IBOutlet weak var speakerName: UILabel!
    @IBOutlet weak var speakerDesc: UILabel!
    
    @IBOutlet weak var favourites: UILabel!
    
        //Switch
    @IBOutlet weak var favouriteSwitch: UISwitch!
        //Buttons
    @IBOutlet weak var twitterPage: UIButton!
    @IBOutlet weak var locationPage: UIButton!
        //Image
    @IBOutlet weak var speakerImage: UIImageView!
        //View
    @IBOutlet weak var SpeakerLabelView: UIView!
    
    // Objects
    var session:Session!
    var speaker:Speaker!
    var location:Location!
    
    //
    //This function sets the UI objects with the session object's data. Also loads in a speaker using session Data.
    //Requires the segue onto the controller to load a session.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        location = DBAccess.sharedInstance.getLocation(locationID: session.locationID)
        
        sessionTitle.text = session.title
        startTime.text = session.timeStart
        endTime.text = session.timeEnd
        sessionType.text = session.type
        sessionDesc.text = session.content
        locationPage.setTitle(location.name, for: .normal)
        if (!(session.type == "workshop" || session.type == "talk")){
            favourites.text = ""
            favouriteSwitch.removeFromSuperview()
        }
        if (session.speakerID != ""){
            speaker = DBAccess.sharedInstance.getSpeaker(session.speakerID)
            speakerName.text = speaker.name
            speakerDesc.text = speaker.biography
            speakerImage.image = UIImage(named: "\(speaker.id).jpg")
            
            speakerImage.layer.borderWidth = 1
            speakerImage.layer.borderColor = UIColor.blue.cgColor
            speakerImage.layer.cornerRadius = speakerImage.frame.height/2
            speakerImage.clipsToBounds = true
            // Referenced [6] to understand how to customise the image once loaded
        }
        else {
            speakerName.text = ""
            speakerDesc.text = ""
            SpeakerLabelView.removeFromSuperview()
            twitterPage.removeFromSuperview()
        }
        
        if(DBAccess.sharedInstance.isFavouriteSession(session: session)){
            favouriteSwitch.setOn(true, animated: false)
        } else {
            favouriteSwitch.setOn(false, animated: false)
        }
        
    }
    
    //
    //This sets if the current session is a favourite session or not
    //
    //Parameters:
    //sender = The UI object that sent the request to execute the function
    //
    @IBAction func changeFavourite(_ sender: Any) {
            if(favouriteSwitch.isOn){
                DBAccess.sharedInstance.addFavouriteSession(favSession: session)
            } else{
                DBAccess.sharedInstance.removeFavouriteSession(favSession: session)
            }
    }
    
    //This method opens the Safari application with link to the twitter page.
    //
    //Parameters:
    //  sender = The UI object that sent the request to execute the function
    //
    @IBAction func toTwitterProfile(_ sender: Any) {
        if(session.speakerID != ""){
            let twitterURL = "http://www.twitter.com/\(speaker.twitter)/"
            
            if let url = URL(string: twitterURL), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false], completionHandler: nil)
            }
            // Reference[5] was used to understand how to open an URL
        }
    }

    //This method sends location object to LocationVC controller
    //
    // Parameters:
    //      segue = The segue from controller being used
    //      any = UI object which called this function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocation" {
            let locationVC = segue.destination as! LocationVC
            locationVC.location = self.location
        }
    }
}
