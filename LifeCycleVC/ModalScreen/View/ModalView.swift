//
//  ModalView.swift
//  LifeCycleVC
//
//  Created by Максим on 18.03.2021.
//

import UIKit

class ModalView: UIView {
    
    var textLabel: String?
    var image: UIImage?
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emptyImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let materialImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let materialLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat(24), weight: .light)
        label.shadowColor = .black
        label.textColor = .white
        label.backgroundColor = .systemGray4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 9
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    var closeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Close", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.black, for: .highlighted)
        return btn
    }()
    
    var doneBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Done", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.darkGray, for: .normal)
        return btn
    }()
    
    var textfield: UITextField = {
        let field = UITextField()
        field.placeholder = "Ваш коментарий"
        field.font = UIFont.systemFont(ofSize: 15)
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.autocorrectionType = UITextAutocorrectionType.no
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.send
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        field.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPink
        
        textfield.delegate = self
        
        notificatirorsSetup()
        
        // Download data
        textLabel = "Image Text"
        image = UIImage(named: "image-1")
        
        // Setup view with data
        materialLabel.text = textLabel
        materialImage.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func notificatirorsSetup() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(sender:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(sender:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.size.height + 20
            scrollView.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
    }
        
    private func setupViews() {
        
        let safeArea = safeAreaLayoutGuide
        let padding: CGFloat = 18
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -padding),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -padding)
        ])
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding)
        ])
        
        contentView.addSubview(emptyImageView)
        NSLayoutConstraint.activate([
            emptyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            emptyImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            emptyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            emptyImageView.heightAnchor.constraint(equalToConstant: 400),
            emptyImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -padding * 6)
        ])
        
        emptyImageView.addSubview(materialImage)
        NSLayoutConstraint.activate([
            materialImage.leadingAnchor.constraint(equalTo: emptyImageView.leadingAnchor),
            materialImage.topAnchor.constraint(equalTo: emptyImageView.topAnchor),
            materialImage.trailingAnchor.constraint(equalTo: emptyImageView.trailingAnchor),
            materialImage.bottomAnchor.constraint(equalTo: emptyImageView.bottomAnchor)
        ])
        
        contentView.addSubview(materialLabel)
        NSLayoutConstraint.activate([
            materialLabel.leadingAnchor.constraint(equalTo: materialImage.leadingAnchor),
            materialLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: padding),
            materialLabel.trailingAnchor.constraint(equalTo: materialImage.trailingAnchor),
        ])
        
        stackView.addArrangedSubview(closeBtn)
        stackView.addArrangedSubview(doneBtn)
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: materialLabel.bottomAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        contentView.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            textfield.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            textfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    func animateMaterialImage() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 10) {
            //************** Разобраться почему не работает анимация констрейнтов
            self.layoutIfNeeded()
        }
    }

}

extension ModalView: UITextFieldDelegate {
        
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textfield.text {
            materialLabel.text = text == "" ? "Image Text" : text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
    }
}
