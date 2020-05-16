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
    
}

extension RoutineDetailViewController {
    
    func setupView(){
        title = routine?.title
        
        view.backgroundColor = .lightGray
        
    }
    
}
