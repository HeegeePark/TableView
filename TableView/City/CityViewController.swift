//
//  CityViewController.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

enum CityType: String, CaseIterable {
    case all = "모두"
    case domestic = "국내"
    case abroad = "해외"
    
    var cityList: [City] {
        let list = City.getDummy()
        switch self {
        case .all:
            return list
        case .domestic:
            return list.filter { $0.domesticTravel }
        case .abroad:
            return list.filter { !$0.domesticTravel }
        }
    }
}

class CityViewController: UIViewController {

    @IBOutlet var citySegmentControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!

    var cityType: CityType = .all
    var cityList: [City] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityList = self.cityType.cityList
        setCollectionView()
        setSegmentControl()
    }
    
    func setCollectionView() {
        registerXib()
        connectDelegate()
        collectionView.setLayout(inset: 20, spacing: 20, ratio: 1.4, colCount: 2)
    }
    
    // XIB 셀 연결
    func registerXib() {
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib,forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
    }
    
    // 프로토콜 연결
    func connectDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setSegmentControl() {
        for (i, type) in CityType.allCases.enumerated() {
            citySegmentControl.setTitle(type.rawValue, forSegmentAt: i)
        }
        citySegmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        citySegmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    // segmentedControl 값 변경 시
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        cityType = CityType.allCases[sender.selectedSegmentIndex]
        cityList = cityType.cityList
    }
}

extension CityViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        let city = cityList[indexPath.item]
        
        cell.bindItem(data: city)
        
        return cell
    }
}
