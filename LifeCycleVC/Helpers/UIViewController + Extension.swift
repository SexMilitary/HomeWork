//
//  UIViewController + Extension.swift
//  LifeCycleVC
//
//  Created by Максим on 21.03.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, and message: String, completion: @escaping() -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showChoiceAlert(with title: String, and message: String, cancel: String, confirm: String, style: UIAlertAction.Style, completion: @escaping() -> Void = { }) {
        
        let alertController = UIAlertController(title: title, message: message,  preferredStyle: .alert)
        
        let delete = UIAlertAction(title: confirm, style: style) { (_) in
            completion()
        }
        
        let cancel = UIAlertAction(title: cancel, style: .cancel) { (_) in
            
        }
        
        alertController.addAction(delete)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
}
