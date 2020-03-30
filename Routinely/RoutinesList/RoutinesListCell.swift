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
        
    var viewModel: RoutinesListCellViewModel? {
        didSet {
            render()
        }
    }
            
    var isInProgress: Bool = false
    
    var startedAt: String?
    
    var timer = Timer()
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
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
        button.layer.cornerRadius = 20
        button.contentEdgeInsets.top = 7
        button.contentEdgeInsets.bottom = 7
        button.contentEdgeInsets.left = 15
        button.contentEdgeInsets.right = 15
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var runningRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle("00:00", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 20
        button.contentEdgeInsets.top = 7
        button.contentEdgeInsets.bottom = 7
        button.contentEdgeInsets.left = 15
        button.contentEdgeInsets.right = 15
        button.addTarget(self, action: #selector(runningTapped), for: .touchUpInside)
        return button
    }()
    
     lazy var borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.clipsToBounds = false
        return view
    }()
    
    // MARK: - Actions

    @objc func startTapped(_ sender: UIButton) {
        isInProgress = !isInProgress
        startRoutineButton.isHidden = true
        runningRoutineButton.isHidden = false
        startedAt = String(Int(Date().timeIntervalSince1970))
        tick()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    
    @objc func runningTapped(_ sender: UIButton) {
        isInProgress = !isInProgress
        startRoutineButton.isHidden = false
        runningRoutineButton.isHidden = true
        timer.invalidate()
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
        backgroundColor = .clear
        selectionStyle = .none
        
        borderView.addSubview(titleLabel)
        borderView.addSubview(descriptionLabel)
        borderView.addSubview(startRoutineButton)
        borderView.addSubview(runningRoutineButton)
        addSubview(borderView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(startRoutineButton.snp.top).offset(-10)
        }
        
        startRoutineButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        runningRoutineButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.greaterThanOrEqualTo(92)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-13)
        }
        
    }
    
    func render() {
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.description
        isInProgress = viewModel?.isInProgress ?? false
        startedAt = viewModel?.startedAt
        startRoutineButton.isHidden = isInProgress ? true : false
        runningRoutineButton.isHidden = isInProgress ? false : true
    }
    
    @objc func tick() {
        guard let startedAt = startedAt else {
            return
        }
        let newTime = Int(Date().timeIntervalSince1970)
        let time = newTime - Int(startedAt)!
        runningRoutineButton.setTitle(formatTime(interval: time), for: .normal)
    }
    
    func formatTime(interval: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        var formattedString = formatter.string(from: TimeInterval(interval))!
        if formattedString.hasPrefix("00:") {
            formattedString = String(formattedString.dropFirst(3))
        }
        return formattedString
    }
    
}
