//
//  SpeakerTVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 26/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit

// Displays a list of speakers
//
class SpeakerTVC: UITableViewController {
    //Objects
    var speakers:[Speaker]!
    
    // Loads the speakers data from database to speakers array in class
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        speakers = DBAccess.sharedInstance.getSpeakers()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //
    // Sets amount of rows to amount of speakers
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }

    //
    // Adds text which is speakers name to each cell
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "speakerCell", for: indexPath)
        cell.textLabel?.text = speakers[indexPath.row].name

        return cell
    }
    
    // MARK: - Navigation
    
    //This method sends speaker object to SpeakerDetailsVC controller
    //
    // Parameters:
    //      segue = The segue from controller being used
    //      any = UI object which called this function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpeakerDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! SpeakerDetailsVC
                detailVC.speaker = speakers[indexPath.row]
                
            }
        }
    }

}
