//
//  RequestViewController.swift
//  LifeCycleVC
//
//  Created by Максим on 21.03.2021.
//

import UIKit

public enum Actions: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case del = "DELETE"
    case posturlencoded = "URLENCODED"
}

private enum LayoutConstant {
    static let spacing: CGFloat = 16.0
    static let itemHeight: CGFloat = 150.0
}

class RequestViewController: UIViewController {
    
    let actions = Actions.allCases
    
    var dataFetcherService = DataFetcherService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "URLRequests"
        view.backgroundColor = .systemBackground
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(RequestCollectionViewCell.self,
                                forCellWithReuseIdentifier: RequestCollectionViewCell.reuseIdentifier)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemBackground
        
        self.view.addSubview(collectionView)
    }

}

extension RequestViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! RequestCollectionViewCell
        cell.set(for: indexPath.row, label: actions[indexPath.row].rawValue)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let action = actions[indexPath.row]
        
        switch action {
        case .get:
            print("GET")
            dataFetcherService.fetchGetRequestTest() { (data) in
                self.showAlert(with: "We gote new JSON POST request!",
                               and: "with data:\n \(data!.first!.name!)")
            }
        case .post:
            print("POST")
            dataFetcherService.fetchPostRequestTest(contentType: .json) { (data) in
                guard let data = data else { return }
                self.showAlert(with: "We gote new JSON POST request!",
                               and: "with data:\n \(data.id!),\n\(data.name!),\n\(data.body!),\n\(data.email!)")
            }
        case .patch:
            print("PATCH")
            dataFetcherService.fetchPatchRequestTest { (data) in
                guard let response = data else { return }
                self.showAlert(with: "We gote new JSON PATCH request!",
                               and: "with data:\n \(response.id!),\n\(response.name!),\n\(response.body!),\n\(response.email!)")
            }
        case .del:
            print("DEL")
            dataFetcherService.delPatchRequestTest { (data) in
                guard let _ = data else { return }
                self.showAlert(with: "We gote new JSON DELETE request!",
                               and: "without data!")
            }
        case .posturlencoded:
            print("posturlencoded")
            dataFetcherService.fetchPostRequestTest(contentType: .urlencoded) { (data) in
                self.showAlert(with: "Ошибочка вышла... Или нет!", and: "Не знаю где протестировать это...")
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 0)
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
            let itemsInRow: CGFloat = 2

            let totalSpacing: CGFloat = 3 * spacing - (itemsInRow - 1) * spacing
            let finalWidth = (width - totalSpacing) / itemsInRow - 24

            return finalWidth
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return LayoutConstant.spacing
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return LayoutConstant.spacing
        }
}
