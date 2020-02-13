//
//  FavoritesVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 18/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit

//
// Shows a list of favourite Sessions
class FavoritesTVC: UITableViewController {

    //UI Objects
        //Table View
    @IBOutlet var sessionTableView: UITableView!
    
    //Objects Aryays
    var favList:[Session] = [] // favourite sessions Array
    
    //
    // Reads the favourite Session data
    override func viewDidLoad() {
        super.viewDidLoad()
        favList = DBAccess.sharedInstance.loadFavouriteSessionList()
    }
    
    // MARK: - Table view data source
    
    //Sets number of sessions as 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Sets amount of rows as amount of favourite Cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favList.count
    }
    
    // Loads the Cell data with session data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavSessionCell", for: indexPath) as! SessionTVCell
        
        let selectedSession:Session = favList[indexPath.row]
        cell.setDisplayData(displaySession: selectedSession)
        
        return cell

    }
    
    // Reloads the data onto the table view
    //
    // Parameters:
    //      animated = do you want added cells to be animated onto table view
    override func viewWillAppear(_ animated: Bool) {
        #if DEBUG
        print("FavouritesVC DEBUG: Reloading tableView Data")
        #endif
        favList = DBAccess.sharedInstance.loadFavouriteSessionList()
        self.tableView.reloadData()
    }

    // MARK: - Navigation
    
    //This method sends Session object to SessionDetailVC
    //
    // Parameters:
    //      segue = The segue from controller being used
    //      any = UI object which called this function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSessionDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! SessionDetailVC
                detailVC.session = favList[indexPath.row]
            }
        }
    }
    
}
