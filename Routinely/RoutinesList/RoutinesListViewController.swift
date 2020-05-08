//
//  RoutinesListViewController.swift
//  Routinely
//
//  Created by Aaron Rosenfeld on 3/18/20.
//  Copyright © 2020 Aaron Rosenfeld. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RoutinesListViewController: UIViewController {
        
    var routinesViewModels: [RoutinesListCellViewModel]?
    
    var counter = 0
    
    // MARK: - UI
       
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .lightGray
        tableView.register(RoutinesListCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var addRoutineButton: UIButton = {
       let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(35)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.tintColor = .white
        button.addTarget(self, action: #selector(addRoutineButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addRoutineButtonWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 37.5
        return view
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        routinesViewModels = []
        setupView()
    }
    
    // MARK: - Actions
    
    @objc func addRoutineButtonTapped() {
        let routine = Routine(title: "New Routine \(counter)", description: "This is a new routine", isInProgress: false)
        routinesViewModels?.append(RoutinesListCellViewModel(routine: routine))
        counter = counter + 1
        tableView.reloadData()
    }
    
}

extension RoutinesListViewController {
    
    func setupView() {
        title = "Routines"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(tableView)
        addRoutineButtonWrapper.addSubview(addRoutineButton)
        view.addSubview(addRoutineButtonWrapper)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalTo(view)
        }
        
        addRoutineButton.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        addRoutineButtonWrapper.snp.makeConstraints{ make in
            make.right.equalTo(tableView.snp.right).offset(-40)
            make.bottom.equalTo(tableView.snp.bottom).offset(-75)
            make.height.width.equalTo(75)
        }
                
    }
    
}

extension RoutinesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routinesViewModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RoutinesListCell
        cell.viewModel = routinesViewModels?[indexPath.row]
        cell.delgate = self
        return cell
    }
    
}

extension RoutinesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

extension RoutinesListViewController: RoutinesListCellDelegate {
    
    func actionTapped(viewModel: RoutinesListCellViewModel?) {

        guard  let viewModel = viewModel else {
            return
        }
        if let index = routinesViewModels?.firstIndex(where: { $0.id == viewModel.id }) {
            routinesViewModels?[index] = viewModel
        }
    }
    
}
