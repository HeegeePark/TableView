//
//  CityViewController.swift
//  TableView
//
//  Created by 박희지 on 1/9/24.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet var citySegmentControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    
    let deviceWidth = UIScreen.main.bounds.width
    let cityList: [City] = City.getDummy()
    var cellWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    }
    
    func setCollectionView() {
        // XIB 셀 연결
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib,forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
        // 프로토콜 연결
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 컬렌션뷰 레이아웃 설정
        print("layout")
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 20
        let spacing: CGFloat = 20
        cellWidth = (deviceWidth - (spacing + 2 * inset)) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.4)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
}

extension CityViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else {
            return UICollectionViewCell()
        }
        let city = cityList[indexPath.item]
        
        cell.configureUI(city: city)
        
        return cell
    }
}
