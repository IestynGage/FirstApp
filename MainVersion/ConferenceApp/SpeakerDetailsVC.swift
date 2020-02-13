//
//  SpeakerDetailsVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 26/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit


//This class sets the data onto the SpeakerDetails controller from loaded data, it also deals with funtionality of the controller
//
//Requires the segue onto the controller to load a speaker.
//
class SpeakerDetailsVC: UIViewController {
    
    //UI Objects
        // Labels
    @IBOutlet weak var nameLabel: UILabel!  // the label of the speakers name
    @IBOutlet weak var speakerDescp: UILabel! // the label of descprition of speajer
        // Image
    @IBOutlet weak var profileImage: UIImageView! // an image of the speaker
    
    // Objects
    var speaker:Speaker! // the speaker object that must be loaded from previous controller
    
    //
    // This function sets the UI objects with the speaker object's data
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = speaker.name
        speakerDescp.text = speaker.biography
        profileImage.image = UIImage(named: "\(speaker.id).jpg")
    }
    
    //
    // This method opens the Safari with link to the twitter page.
    //
    // Parameters:
    //      sender = The UI object that sent the request to execute the function
     //
    @IBAction func toTwitterProfile(_ sender: UIButton) {
        let twitterURL = "http://www.twitter.com/\(speaker.twitter)/"
        
        if let url = URL(string: twitterURL), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly : false], completionHandler: nil)
        }
        // Reference[5] was used to understand how to open an URL
    }

}
