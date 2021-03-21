//
//  ItemCell.swift
//  LifeCycleVC
//
//  Created by Максим on 20.03.2021.
//

import UIKit
import Kingfisher

protocol NetworkCellView {
    var iconUrlString: String { get }
    var title: String { get }
    var description: String { get }
}

class NetworkCell: UITableViewCell {
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.backgroundColor = .clear
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 10)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            iconImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            iconImage.widthAnchor.constraint(equalToConstant: self.frame.size.height - 18)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 18),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 9),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 18),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),
            descriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -9)
        ])
    }
    
    func configureCell(with data: NetworkCellView) {
        let url = URL(string: data.iconUrlString)
        self.iconImage.kf.setImage(with: url,
                                   placeholder: UIImage(named: "unnamed"),
                                   options: [])
//        self.iconImage.load(url: url)
        
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
