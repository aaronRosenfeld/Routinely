//
//  RoutineDetailViewController.swift
//  Routinely
//
//  Created by Aaron Rosenfeld on 5/9/20.
//  Copyright © 2020 Aaron Rosenfeld. All rights reserved.
//

import Foundation
import UIKit

class RoutineDetailViewController: UIViewController {
    
    var routine: Routine?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
}

extension RoutineDetailViewController {
    
    func setupView(){
        title = routine?.title
        
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = routine?.isInProgress ?? false ? UIColor.systemRed : UIColor.systemGreen
        
    }
    
}
