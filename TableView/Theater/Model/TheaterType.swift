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
    var mapAnnotations: [Theater] {
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
        return mapAnnotations.count
    }
    
    // annotation들의 center coordinate
    var centerCoordinate: CLLocationCoordinate2D {
        let latitudeCenter = mapAnnotations.map { $0.latitude }.reduce(0, +) / Double(mapAnnotationsCount)
        let longitudeCenter = mapAnnotations.map { $0.longitude }.reduce(0, +) / Double(mapAnnotationsCount)
        
        return CLLocationCoordinate2D(latitude: latitudeCenter, longitude: longitudeCenter)
    }
    
    // center coordinate로부터 가장 큰 span
    // 값이 커질수록 지도 축소
    var maxDistanceSpan: MKCoordinateSpan {
        let latitudeDiffMax = mapAnnotations.map {
            abs(centerCoordinate.latitude - $0.latitude)
        }.max()!
        
        let longitudeDiffMax = mapAnnotations.map {
            abs(centerCoordinate.longitude - $0.longitude)
        }.max()!
        
        return MKCoordinateSpan(latitudeDelta: latitudeDiffMax, longitudeDelta: longitudeDiffMax)
    }
    
    // annotation들의 center region
    var centerRegion: MKCoordinateRegion {
        print(maxDistanceSpan)
        // TODO: 거리 차에 따른 맞춤 span으로 설정하기.
//        return MKCoordinateRegion(center: centerCoordinate, span: maxDistanceSpan)
        return MKCoordinateRegion(center: centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}
