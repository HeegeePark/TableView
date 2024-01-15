//
//  TheaterViewController.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let theaterList = TheaterList.mapAnnotations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
    }
    
    func configureMapView() {
        mapView.showsUserLocation = true
        
        mapView.setRegion(TheaterList.centerRegion, animated: true)
        
        for theater in theaterList {
            mapView.addAnnotation(theater.annotation)
        }
    }
}
