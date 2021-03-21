//
//  NetworkViewController.swift
//  LifeCycleVC
//
//  Created by Максим on 19.03.2021.
//

import UIKit

// MARK: TableViewDelegate

protocol NetworViewControllerDelegate: class {
    func currentSelected(_ indexPath: IndexPath)
}

class NetworkViewController: UIViewController{
    
    var networkTableDataSourse: NetworkTableDataSource!
    var networkTableDelegate: NetworkTableDelegate!
    var dataFetcherService = DataFetcherService()
    
    var data = [NetworkCellView]()
    
    var tableView = UITableView()
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.startAnimating()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        dataFetcherService.fetchNews { [weak self] (news) in
            
            guard let strongSelf = self, let news = news else { return }
            
            if let networkCellView = CellModel.getArticle(from: news) {
                strongSelf.data = networkCellView
            }
            
            strongSelf.networkTableDataSourse.setNewData(with: strongSelf.data)
            strongSelf.activityIndicator.stopAnimating()
            strongSelf.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        networkTableDataSourse = NetworkTableDataSource(tableView: tableView, withData: data)
        networkTableDelegate = NetworkTableDelegate()
        
        networkTableDelegate.presentingController = self
        
        tableView.dataSource = networkTableDataSourse
        tableView.delegate = networkTableDelegate
        
        tableView.register(NetworkCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension NetworkViewController: NetworViewControllerDelegate{
    func currentSelected(_ indexPath: IndexPath) {
        print(indexPath)
    }
    
}
