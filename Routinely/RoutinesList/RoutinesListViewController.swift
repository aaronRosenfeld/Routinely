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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        routinesViewModels = []
        setupView()
    }
    
    // MARK: - Actions
    
    @objc func addRoutineButtonTapped() {
        let vc = NewRoutineViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RoutinesListViewController {
    
    func setupView() {
        title = "Routines"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addRoutineButtonTapped))
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalTo(view)
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
        cell.delegate = self
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

extension RoutinesListViewController: NewRoutineViewControllerDelegate {
    
    func addRoutine(title: String, description: String) {
        let routine = Routine(title: title, description: description, isInProgress: false)
        routinesViewModels?.append(RoutinesListCellViewModel(routine: routine))
        tableView.reloadData()
    }
    
}
