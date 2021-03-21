//
//  SecondBackGroundView.swift
//  LifeCycleVC
//
//  Created by Максим on 18.03.2021.
//

import UIKit

class SecondView: UIView {
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat(28), weight: .light)
        label.shadowColor = .black
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("SecondView", #function)
        
        backgroundColor = .systemBlue
        
        addSubview(alertLabel)
        alertLabel.text = "Смотрим в консоль,\n ждем 10 000,\n выходим из VC...\n Радуемся!"
        constraintsSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func constraintsSetup() {
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo:centerYAnchor)
        ])
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print("SecondView", #function)
        
    }
    
}
