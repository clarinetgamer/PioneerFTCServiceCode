//
//  Tasks.swift
//  SwiftEV3
//
//  Created by Braden Cantor-Goldner on 11/4/19.
//  Copyright © 2019 謝飛飛. All rights reserved.
//

import Foundation

struct Task {
    var lessonNum: Int 
    var directionsText: String
    var simpleAnswer: [Command.Type]?
    var complexAnswer: (String, Int)?
    
    
    init(lessonNum: Int, directionsText: String, simpleAnswer: [Command.Type]) {
        self.lessonNum = lessonNum
        self.directionsText = directionsText
        self.simpleAnswer = simpleAnswer
    }
    init(lessonNum: Int, directionsText: String, complexAnswer: (String, Int)) {
        self.lessonNum = lessonNum
        self.directionsText = directionsText
        self.complexAnswer = complexAnswer
    }
}
