//
//  TheaterType.swift
//  TableView
//
//  Created by 박희지 on 1/16/24.
//

import UIKit
import MapKit

enum TheaterType: String, CaseIterable {
    case megabox = "메가박스"
    case lotteCinema = "롯데시네마"
    case cgv = "CGV"
    case all = "전체보기"
    
    // type에 따른 annotation list
    var theaters: [Theater] {
        let list = TheaterList.mapAnnotations
        switch self {
        case .all:
            return list
        default:
            return list.filter { $0.type == rawValue }
        }
    }
    
    // alert에 쓰일 title
    static var titles: [String] {
        TheaterType.allCases.map { $0.rawValue }
    }
    
    var mapAnnotationsCount: Int {
        return theaters.count
    }
    
    // MKPointAnnotation list
    var mapAnnotations: [MKPointAnnotation] {
        return theaters.map { $0.annotation }
    }
    
    // annotation들의 center coordinate
    var centerCoordinate: CLLocationCoordinate2D {
        let latitudeCenter = theaters.map { $0.latitude }.reduce(0, +) / Double(mapAnnotationsCount)
        let longitudeCenter = theaters.map { $0.longitude }.reduce(0, +) / Double(mapAnnotationsCount)
        
        return CLLocationCoordinate2D(latitude: latitudeCenter, longitude: longitudeCenter)
    }
    
    // 매개변수로 받은 center와 theaters 사이의 최대거리를 구하고, 그에 따른 span return
    // span: 값이 커질수록 지도 반경 up
    func maxDistanceSpan(center: CLLocationCoordinate2D) -> MKCoordinateSpan {
        let latitudeDiffMax = theaters.map {
            abs(center.latitude - $0.latitude)
        }.max()!
        
        let longitudeDiffMax = theaters.map {
            abs(center.longitude - $0.longitude)
        }.max()!
        
        return MKCoordinateSpan(latitudeDelta: latitudeDiffMax * 2 + 0.03, longitudeDelta: longitudeDiffMax * 2 + 0.03)
    }
    
    // center coordinate로부터 구한 span
    var maxDistanceSpanBetweenTheaters: MKCoordinateSpan {
        return maxDistanceSpan(center: centerCoordinate)
    }
    
    // annotation들의 center region
    var centerRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: centerCoordinate, span: maxDistanceSpanBetweenTheaters)
    }
}
