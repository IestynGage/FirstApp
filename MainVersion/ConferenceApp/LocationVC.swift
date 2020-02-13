//
//  LocationVC.swift
//  ConferenceApp
//
//  Created by ieg4 on 01/12/2019.
//  Copyright © 2019 ieg4. All rights reserved.
//

import UIKit
import MapKit

//
// This class is used to load a location onto a controller. Segue onto controller must set location object for controller to work.
//
class LocationVC: UIViewController {
    // UI Objects
        // Labels
    @IBOutlet weak var locationName: UILabel!   // label with location name
    @IBOutlet weak var locationDescp: UILabel!  // label with descprition of the location
        // MARK: Map
    @IBOutlet weak var locationMap: MKMapView! // The Map which the location will be loaded onto
    // MARK: Objects
    var location:Location! // The location used to center the map. Location must be set during the segue onto the controller.
    
    //
    // Used to center the map to the location coordiantes.
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        locationName.text = location.name
        locationDescp.text = location.description
        
        let locationCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude:location.latitude, longitude: location.longitude)
        let cameraDistance:CLLocationDistance = CLLocationDistance(2000)
        
        let cameraCenter = MKMapCamera(lookingAtCenter: locationCoordinate, fromEyeCoordinate: locationCoordinate, eyeAltitude: cameraDistance)
        
        let locationPointer = MKPointAnnotation()
        locationPointer.title = location.name
        locationPointer.coordinate = locationCoordinate
        
        locationMap.setCamera(cameraCenter, animated: false)
        locationMap.addAnnotation(locationPointer)
    }

}
