//
//  Theater.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import Foundation
import MapKit

struct Theater {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
    
    var annotation: MKPointAnnotation {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = location
        
        return annotation
    }
}

