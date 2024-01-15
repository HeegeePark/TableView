//
//  MagazineWebViewController.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import UIKit
import WebKit

class MagazineWebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    
    var magazine: Magazine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureNavigationBar()
        loadWebViw()
    }
    
    func bindItem(data: Magazine) {
        magazine = data
    }
    
    func loadWebViw() {
        guard let magazine else { return }
        let request = URLRequest(url: magazine.linkURL)
        
        webView.load(request)
    }
    
    @objc func popButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension MagazineWebViewController: CustomViewControllerProtocol {
    func setupUI() {}
    
    func configureNavigationBar() {
        navigationItem.title = magazine?.title
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
}
