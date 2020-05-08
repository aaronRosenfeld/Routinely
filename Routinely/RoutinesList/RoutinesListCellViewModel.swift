//
//  RoutinesListCellViewModel.swift
//  Routinely
//
//  Created by Aaron Rosenfeld on 3/29/20.
//  Copyright © 2020 Aaron Rosenfeld. All rights reserved.
//

import Foundation

class RoutinesListCellViewModel {
    
    var id: UUID?
    
    var title: String?
    
    var description: String?
    
    var startedAt: String?
    
    var isInProgress: Bool
    
    init(routine: Routine?) {
        id = routine?.id
        title = routine?.title
        description = routine?.description
        startedAt = routine?.startedAt
        isInProgress = routine?.isInProgress ?? false
    }
    
}
