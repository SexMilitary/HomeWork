//
//  RequestCollectionViewCell.swift
//  LifeCycleVC
//
//  Created by Максим on 21.03.2021.
//

import UIKit

class RequestCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RequestCollectionViewCell"
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        backgroundColor = .systemBlue
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
    
    func set(for number: Int, label: String) {
        titleLabel.text = label
        
        let actions = Actions.allCases
        switch actions[number] {
        case .get:
            backgroundColor = .blue
        case .post:
            backgroundColor = .orange
        case .posturlencoded:
            backgroundColor = .purple
        case .patch:
            backgroundColor = .systemTeal
        case .del:
            backgroundColor = .red
        }
    }
    
}
