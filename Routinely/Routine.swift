//
//  Routine.swift
//  Routinely
//
//  Created by Aaron Rosenfeld on 3/28/20.
//  Copyright © 2020 Aaron Rosenfeld. All rights reserved.
//

import Foundation

class Routine {
    var id: UUID?
    var title: String?
    var description: String?
    var isInProgress: Bool = false
    var startedAt: String?
    
    init(title: String?, description: String?, isInProgress: Bool = false, startedAt: String? = nil) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.isInProgress = isInProgress
        self.startedAt = startedAt
    }
}
