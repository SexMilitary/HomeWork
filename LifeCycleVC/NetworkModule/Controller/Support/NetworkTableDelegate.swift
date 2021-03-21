//
//  TableViewDelegate.swift
//  LifeCycleVC
//
//  Created by Максим on 19.03.2021.
//

import UIKit

class NetworkTableDelegate: NSObject, UITableViewDelegate {
    
    var presentingController: NetworViewControllerDelegate?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentingController?.currentSelected(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
}
