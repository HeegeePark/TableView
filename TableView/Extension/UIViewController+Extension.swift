//
//  UIViewController+Extension.swift
//  TableView
//
//  Created by 박희지 on 1/15/24.
//

import UIKit

extension UIViewController: ReusableProtocol {
    
    
    // 액션시트 present
    func presentActionSheet(titles: [String], completion: @escaping ((String) -> Void)) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for title in titles {
            let action = UIAlertAction(title: title, style: .default, handler: { _ in
              completion(title)
            })
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // 알럿 present
    func presentAlert(title: String?, message: String?, actions: UIAlertAction..., cancelEnabled: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        if cancelEnabled {
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        }
        
        present(alert, animated: true)
    }
}
