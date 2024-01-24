//
//  ADViewController.swift
//  TableView
//
//  Created by 박희지 on 1/11/24.
//

import UIKit

class ADViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }
    
    @objc func dismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - Custom UI
extension ADViewController: CustomViewControllerProtocol {
    func configureView() {}
    
    func configureNavigationBar() {
        navigationItem.title = "광고 화면"
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonClicked))
        navigationItem.leftBarButtonItem = leftButton
    }
}
