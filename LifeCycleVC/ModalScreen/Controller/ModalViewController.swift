//
//  ModalViewController.swift
//  LifeCycleVC
//
//  Created by Максим on 18.03.2021.
//

import UIKit

class ModalViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        let view = ModalView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ModalVC", #function)
        title = "Modal View"
        
        (view as? ModalView)?.closeBtn.addTarget(self, action: #selector(closeModalViewController(sender:)), for: .touchUpInside)
        (view as? ModalView)?.doneBtn.addTarget(self, action: #selector(closeModalViewController(sender:)), for: .touchUpInside)
    }
    
    @objc func closeModalViewController(sender: UIButton) {
        sender.backgroundColor = .blue
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ModalVC", #function)
    }
    
    //---Layout-------------------------------------------------------------------
    override func viewWillLayoutSubviews() {
        print("ModalVC", #function)
    }
    
    override func viewLayoutMarginsDidChange() {
        print("ModalVC", #function)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        print("ModalVC", #function)
    }
    
    override func updateViewConstraints() {
        print("ModalVC", #function)

        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        print("ModalVC", #function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("ModalVC", #function)
    }
    //---Layout-------------------------------------------------------------------
    
    
    //***Пользователь увидел экран***
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ModalVC", #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        print("ModalVC", #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        print("ModalVC", #function)
    }
    
    deinit {
        print("ModalVC", #function)
    }
    
    override func didReceiveMemoryWarning() {
        print("ModalVC", #function)
    }    
    
}
