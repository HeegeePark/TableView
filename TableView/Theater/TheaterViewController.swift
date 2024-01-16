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
    
    var type: TheaterType = .all {
        didSet {
            theaterList = type.mapAnnotations
        }
    }
    
    lazy var theaterList = type.mapAnnotations {
        didSet {
            reloadMapView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @objc func filterButtonTapped() {
        presentActionSheet(titles: TheaterType.titles) { rawValue in
            self.type = TheaterType.init(rawValue: rawValue) ?? .all
        }
    }
    
    func reloadMapView() {
        mapView.setRegion(type.centerRegion, animated: true)
        
        // 모든 annotation clear하고 다시 추가하기
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(theaterList)
    }
}

// MARK: - Custom UI
extension TheaterViewController: CustomViewControllerProtocol {
    func setupUI() {
        configureNavigationBar()
        configureMapView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "주변 영화관 탐색"
        
        let rightButton = UIBarButtonItem(title: "Filter", image: nil, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func configureMapView() {
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        mapView.setRegion(type.centerRegion, animated: true)
        mapView.addAnnotations(theaterList)
    }
}

// MARK: - MKMapViewDelegate
extension TheaterViewController: MKMapViewDelegate {
    
}
