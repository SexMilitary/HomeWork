//
//  FirstView.swift
//  LifeCycleVC
//
//  Created by Максим on 18.03.2021.
//

import UIKit

class FirstView: UIView {
    
    //MARK: - Views
    var navigationButton: UIButton!
    var modalButton: UIButton!
    
    //MARK: - Properties
    public var delegate: MainViewControllerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("FirstView", #function)
        
        backgroundColor = .systemBackground
        
        setupNavigationButton()
        setupModalButton()
    }
    
    fileprivate func setupNavigationButton() {
        navigationButton = UIButton(title: "Navigation VC\nautoreleasepool",
                                    titleColor: .darkGray,
                                    backgroundColor: .white,
                                    font: .systemFont(ofSize: 18),
                                    isShadow: true,
                                    cornerRadius: 8.0,
                                    icon: nil,
                                    imageRightEdgeInsets: 0.0)
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationButton.addTarget(self, action: #selector(navigationButtonPressed), for: .touchUpInside)
        
        addSubview(navigationButton)
    }
    
    @objc func navigationButtonPressed() {
        print("Button pressed!")
        
        delegate?.navigationButtonAction()
    }
    
    fileprivate func setupModalButton() {
        modalButton = UIButton(title: "Modal VC",
                                    titleColor: .darkGray,
                                    backgroundColor: .white,
                                    font: .systemFont(ofSize: 18),
                                    isShadow: true,
                                    cornerRadius: 8.0,
                                    icon: nil,
                                    imageRightEdgeInsets: 0.0)
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        
        modalButton.addTarget(self, action: #selector(modalButtonPressed), for: .touchUpInside)
        
        addSubview(modalButton)
    }
    
    @objc func modalButtonPressed() {
        print("Button pressed!")
        
        delegate?.modalButtonPressed()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print("FirstView", #function)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print("FirstView", #function)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Вызывается каждый раз, когда необходимо пересчитать все фреймы у вьюшек.
        //Обрабатывает перемещения и изменения размера View и всех его Subviews.
        //Дает им положение и размер.
        //Энергозатратный метод. Вызывает методы layoutSubviews у всех Subviews.
        print("FirstView", #function)
        
        addButtonConstraints()
        
        navigationButton.layer.shadowRadius = 9
        navigationButton.layer.shadowOffset = CGSize(width: 5, height: 6)
        navigationButton.layer.shadowOpacity = 0.3
        navigationButton.clipsToBounds = false
        
        //По завершению этого метода срабатывает viewDidLayoutSubviews в VC.
        //Единственный метод, который надежно вызывается после обновления layout у Vuew.
    }
    
    fileprivate func addButtonConstraints() {
        NSLayoutConstraint.activate([
            navigationButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            navigationButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        navigationButton.titleLabel?.lineBreakMode = .byWordWrapping
        navigationButton.titleLabel?.numberOfLines = 2
        navigationButton.titleLabel?.textAlignment = .center
        
        NSLayoutConstraint.activate([
            modalButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 80),
            modalButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
