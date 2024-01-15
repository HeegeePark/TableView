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
        let list = City.dummy
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
    @IBOutlet var searchBar: UISearchBar!
    
    var cityType: CityType = .all
    var cityList: [City] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityList = self.cityType.cityList
        
        setSearchBar()
        configureCollectionView()
        setSegmentControl()
    }
    
    // segmentedControl 값 변경 시
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        cityType = CityType.allCases[sender.selectedSegmentIndex]
        searchBar(searchBar, textDidChange: searchBar.text ?? "")
    }
}

// MARK: - Custom UI 관련
extension CityViewController: CustomViewControllerProtocol, UICollectionViewControllerProtocol {
    func setupUI() {}
    
    func setSearchBar() {
        searchBar.placeholder = "가고 싶은 도시를 입력해주세요"
        searchBar.delegate = self
    }
    
    func configureCollectionView() {
        registerXib()
        connectDelegate()
        configureLayout()
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
    
    func configureLayout() {
        collectionView.setLayout(inset: 20, spacing: 20, ratio: 1.4, colCount: 2)
    }
    
    // 세그먼트 컨트롤 셋업
    func setSegmentControl() {
        for (i, type) in CityType.allCases.enumerated() {
            citySegmentControl.setTitle(type.rawValue, forSegmentAt: i)
        }
        citySegmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .selected)
        citySegmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: CityDetailViewController.identifier) else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension CityViewController: UISearchBarDelegate {
    // 텍스트가 바뀔 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // text empty 바인딩
        guard !searchText.isEmpty else {
            cityList = cityType.cityList
            return
        }
        
        // whitespace & 소문자화
        let refinedText = searchText.removeWhitespace().lowercased()
        
        // list 셋업
        cityList = cityType.cityList.filter { city in
            return city.name.contains(refinedText) ||
            city.englishName.lowercased().contains(refinedText) ||
            city.explain.contains(refinedText)
        }
    }
    
    // search 버튼 클릭 시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
