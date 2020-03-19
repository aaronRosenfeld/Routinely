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
    
    // MARK: - UI
       
       private lazy var tableView: UITableView = {
           let tableView = UITableView(frame: .zero)
           tableView.delegate = self
           tableView.dataSource = self
//           tableView.separatorColor = .clear
           tableView.register(RoutinesListCell.self, forCellReuseIdentifier: "cell")
           return tableView
       }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        let request = RepositoryRequest()
//        request.getRepositories { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let repositories):
//                self?.repositories = repositories
//            }
//        }
        setupView()
    }
    
}

extension RoutinesListViewController {
    
    func setupView() {
        title = "Routines"
        view.backgroundColor = .white
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutTapped))
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.leading.trailing.equalTo(view)
        }
    }
    
}

extension RoutinesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RoutinesListCell
        return cell
    }
    
}

extension RoutinesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
