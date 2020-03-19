//
//  RoutinesListCell.swift
//  Routinely
//
//  Created by Aaron Rosenfield on 3/18/20.
//  Copyright © 2020 Aaron Rosenfeld. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RoutinesListCell: UITableViewCell {
    
//    var nameLabelText: String? {
//        didSet {
//            render()
//        }
//    }
//
//    var descriptionLabelText: String? {
//           didSet {
//               render()
//           }
//       }
    
    var nameLabelText = "Routine 1"
    
    var descriptionLabelText = "This is a routine for you to do sometimes, I guess."
    
    // MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = nameLabelText
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = descriptionLabelText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var startRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        button.backgroundColor = .systemGreen
        button.titleLabel?.tintColor = .black
        button.layer.cornerRadius = 8
        button.contentEdgeInsets.top = 7
        button.contentEdgeInsets.bottom = 7
        button.contentEdgeInsets.left = 15
        button.contentEdgeInsets.right = 15
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    
     lazy var borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - Actions

    @objc func startTapped(_ sender: UIButton) {
        UIButton.animate(withDuration: 0.1,
                         animations: { sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96) },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.1, animations: {
                                    sender.transform = CGAffineTransform.identity
                            })
                          })
        
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RoutinesListCell {
    
    func setupView() {
        borderView.addSubview(nameLabel)
        borderView.addSubview(descriptionLabel)
        borderView.addSubview(startRoutineButton)
        addSubview(borderView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(startRoutineButton.snp.top).offset(-10)
        }
        
        startRoutineButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
    }
    
    func render() {
        nameLabel.text = nameLabelText
        descriptionLabel.text = descriptionLabelText
    }
    
}
