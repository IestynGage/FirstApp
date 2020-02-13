//
//  MapVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 30/11/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit
import MapKit

//
// This class is used to load a map of aberyswyth will pointers to all the locations.
//
class MapVC: UIViewController {

    //UI Objects
     //Map
    @IBOutlet weak var map: MKMapView! // Map object which will load the map
    
    //
    // Called on startup. It loads the map of aberyswyth with pin for every location.
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aberyswythCenter:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude:52.417131, longitude: -4.063717)
        let cameraDistance:CLLocationDistance = CLLocationDistance(4500)
        
        let cameraCenter = MKMapCamera(lookingAtCenter: aberyswythCenter, fromEyeCoordinate: aberyswythCenter, eyeAltitude: cameraDistance)
        
        let allLocations:[Location] = DBAccess.sharedInstance.getAllLocation()
        print(allLocations[1].getString())
        for location in allLocations{
            let locationMapPointer = MKPointAnnotation()
            locationMapPointer.title = location.name
            locationMapPointer.coordinate = CLLocationCoordinate2D.init(latitude: location.latitude, longitude: location.longitude)
            map.addAnnotation(locationMapPointer)
        }
    
        map.setCamera(cameraCenter, animated: false)
        // Do any additional setup after loading the view.
    }

}
