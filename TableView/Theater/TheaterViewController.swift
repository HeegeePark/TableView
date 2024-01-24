//
//  TheaterViewController.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import UIKit
import MapKit

// TODO: 최초 진입 시, 전체보기 시 센터는 사용자 위치

class TheaterViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var type: TheaterType = .all {
        didSet {
            reloadMapViewByTheater()
        }
    }
    
    // 사용자 위치 coordinate
    // 권한 거부 시, default는 새싹 캠퍼스
    lazy var userCoordinate: CLLocationCoordinate2D = .init(latitude: 37.654165, longitude: 127.049696) {
        didSet {
            reloadMapViewByUserCenter()
        }
    }
    
    var centerRegionByUser: MKCoordinateRegion {
        return MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 400, longitudinalMeters: 400)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLocationManager()
    }
    
    func reloadMapViewByUserCenter() {
        mapView.setRegion(centerRegionByUser, animated: true)
    }
    
    
    func reloadMapViewByTheater() {
        mapView.setRegion(type.centerRegion, animated: true)
        
        // 모든 annotation clear하고 다시 추가하기
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(type.mapAnnotations)
    }
    
    @objc func filterButtonTapped() {
        presentActionSheet(titles: TheaterType.titles) { rawValue in
            self.type = TheaterType.init(rawValue: rawValue) ?? .all
        }
    }
}

// MARK: - CLLocation
extension TheaterViewController {
    func configureLocationManager() {
        locationManager.delegate = self
        
        configureLocationAuthorization()
    }
    
    func configureLocationAuthorization() {
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.handleLocationAuthorization(status: authorization)
                }
            } else {
                print("시스템 위치 서비스 꺼짐")
                // 알아서 설정 이동 알럿 띄워줌
                // 연속 2번 앱 실행 시 취소 누르면, 다음 앱 실행 시 꺼져 있어도 알럿 안뜸. 왜그런겨?
            }
        }
    }
    
    func handleLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("denied")
            self.showLocationSettingAlert()
        case .authorizedWhenInUse:
            print("whenInUse")
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // TODO: 알럿 익스텐션으로 빼기
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없음.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정 이동", style: .default) { _ in
            
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 가셈")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

// MARK: - CLLocationDelegate
extension TheaterViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print("success coordinate: ", coordinate)
            userCoordinate = coordinate
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: center region을 새싹으로
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleLocationAuthorization(status: manager.authorizationStatus)
    }
}

// MARK: - Custom UI
extension TheaterViewController: CustomViewControllerProtocol {
    func configureView() {
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
        
        mapView.setRegion(centerRegionByUser, animated: true)
        mapView.addAnnotations(type.mapAnnotations)
    }
}

// MARK: - MKMapViewDelegate
extension TheaterViewController: MKMapViewDelegate {
    
}
