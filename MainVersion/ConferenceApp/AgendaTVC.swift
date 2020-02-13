//
//  AgendaTableVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 19/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//
import UIKit

//
// Shows a list of sessions with or with out a filter
class AgendaTVC: UITableViewController {

    // Object Arrays
    var agendaList:[Session] = [] // Sessions to be displayed
    var rowsInSecion:[Int] = [] // rows in each section
    var totalPreviousSection:[Int] = [] // Sum of rows in all previous sections (or days)
    //Objects
    var filter:Filter = Filter.init() // filter to be applied
    
    //
    // sets agendaList with SQL date with applied data
    override func viewDidLoad() {
        super.viewDidLoad()
        agendaList = DBAccess.sharedInstance.getSessions(filter: self.filter)
    }

    // MARK: - Table view data source

    // Sets the number of section to 4
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    // Sets the number of rows in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSecion[section]
    }
    
    // Sets the title for each section
    override func tableView(_  tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Day \(section + 1)"
    }

    //
    // Creates the cell for each session as well as loading data into each cell
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell",for: indexPath) as! SessionTVCell
        
        let selectedSession:Session = agendaList[indexPath.row + totalPreviousSection[indexPath.section]]
        cell.setDisplayData(displaySession: selectedSession)
       
        return cell
    }
    
    // Reloads the data onto the table view
    //
    // Parameters:
    //      animated = do you want added cells to be animated onto table view
    override func viewWillAppear(_ animated: Bool) {
        #if DEBUG
        print("AgendaTVC DEBUG: Reloading tableView Data")
        print("AgendaTVC DEBUG: Current filter Data " + filter.getString())
        #endif
        
        agendaList = DBAccess.sharedInstance.getSessions(filter: self.filter)
        self.setRowArrys()
        self.tableView.reloadData()
    }
    
    //Sets rowsInSection and totalPreviousSection array Data
    func setRowArrys(){
        var day1Count:Int = 0
        var day2Count:Int = 0
        var day3Count:Int = 0
        var day4Count:Int = 0
        
        for session in agendaList{
            switch(session.date){
                case "2019-12-10":
                    day1Count += 1
                    break
                case "2019-12-11":
                    day2Count += 1
                    break
                case "2019-12-12":
                    day3Count += 1
                    break
                case "2019-12-13":
                    day4Count += 1
                    break
                default:
                    break
            }
        }
        rowsInSecion = [day1Count,day2Count,day3Count,day4Count]
        totalPreviousSection = [0,day1Count,(day1Count+day2Count),(day1Count+day2Count+day3Count)]
    }
    
    // MARK: Navigation
    
    //This method sends Session or filter object to correct controller (Either SessionDetailVC or FilterVC Controller)
    //
    // Parameters:
    //      segue = The segue from controller being used
    //      any = UI object which called this function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedSegue:String = segue.identifier ?? "Error"
        switch(selectedSegue){
        case "ShowSessionDetail":
            if let indexPath = self.tableView.indexPathForSelectedRow {
                    let detailVC = segue.destination as! SessionDetailVC
                detailVC.session = agendaList[indexPath.row + totalPreviousSection[indexPath.section]]

                    
                }
            break
            
        case "AgendaToFilter":
            let filterVC = segue.destination as! FilterVC
            filterVC.filter = self.filter
            break
            
        case "Error":
            #if DEBUG
                print("AgendaTVC Error: Could not find segue identifier")
            #endif
            break
            
        default:
            #if DEBUG
            print("AgendaTVC Error: identifier not recongised in prepare()")
            #endif
            break
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "ShowSessionDetail"){
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedSession:Session = agendaList[indexPath.row + totalPreviousSection[indexPath.section]]
                if(selectedSession.type == "workshop" || selectedSession.type == "talk"){
                    return true
                    
                } else {
                    return false
                }
        }
    }
        return true

    }
}
