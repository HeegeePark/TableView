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
    
    let deviceWidth = UIScreen.main.bounds.width
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
        // XIB 셀 연결
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib,forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
        // 프로토콜 연결
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 컬렌션뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 20
        let spacing: CGFloat = 20
        let cellWidth = (deviceWidth - (spacing + 2 * inset)) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.4)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
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
        
        cell.configureUI(city: city)
        
        return cell
    }
}
