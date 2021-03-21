//
//  UIImage + Extension.swift
//  LifeCycleVC
//
//  Created by Максим on 21.03.2021.
//

import UIKit

extension UIImageView {
    func load(url: URL?) {
        guard let url = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                strongSelf.image = image
            }
        }
    }
}
