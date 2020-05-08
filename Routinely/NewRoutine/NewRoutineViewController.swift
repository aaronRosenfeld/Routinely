//
//  NewRoutineViewController.swift
//  Routinely
//
//  Created by Aaron Rosenfeld on 5/8/20.
//  Copyright © 2020 Aaron Rosenfeld. All rights reserved.
//

import Foundation
import UIKit

protocol NewRoutineViewControllerDelegate: class {
    
    func addRoutine(title: String, description: String)
    
}

class NewRoutineViewController: UIViewController {
    
    weak var delegate: NewRoutineViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var titleField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Title"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var descriptionField: UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.text = "Description..."
        tv.textColor = .lightGray
        tv.backgroundColor = .white
        return tv
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Routine", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    
    @objc func addTapped() {
        delegate?.addRoutine(title: titleField.text ?? "", description: descriptionField.text)
        navigationController?.popViewController(animated: true)
    }
}

extension NewRoutineViewController {
    
    func setupView() {
        view.backgroundColor = .lightGray
        
        title = "Add Routine"
        
        view.addSubview(titleField)
        view.addSubview(descriptionField)
        view.addSubview(addButton)
        
        titleField.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        descriptionField.snp.makeConstraints{ make in
            make.top.equalTo(titleField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleField)
            make.height.equalTo(100)
        }
        
        addButton.snp.makeConstraints{ make in
            make.top.equalTo(descriptionField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(titleField)
        }
        
    }
    
}

extension NewRoutineViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Description..." && textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Description..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
}
