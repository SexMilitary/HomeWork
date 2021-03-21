//
//  NetworkTableViewDataSource.swift
//  LifeCycleVC
//
//  Created by Максим on 19.03.2021.
//

import UIKit

class NetworkTableDataSource: NSObject, UITableViewDataSource {
    
    private var tableView: UITableView
    private var items: [NetworkCellView]!
    
    init(tableView: UITableView, withData data: [NetworkCellView]) {
        self.tableView = tableView
        self.items = data
    }
    
    func setNewData(with data: [NetworkCellView]) {
        self.items = data
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NetworkCell(style: .default, reuseIdentifier: "Cell")
        cell.configureCell(with: items[indexPath.row])
        
        return cell
    }
    
}
