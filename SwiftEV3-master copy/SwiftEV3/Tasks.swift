//
//  Tasks.swift
//  SwiftEV3
//
//  Created by Braden Cantor-Goldner on 11/4/19.
//  Copyright © 2019 謝飛飛. All rights reserved.
//

import Foundation

struct Task {
    var lessonNum: Double
    var directionsText: String
    var simpleAnswer: [Command.Type]?
    var complexAnswer: (String, Int)?
    
    var showTaskButtons: ShowTaskButtons

    init(lessonNum: Double, directionsText: String, simpleAnswer: [Command.Type], showTaskButtons: ShowTaskButtons) {
        self.lessonNum = lessonNum
        self.directionsText = directionsText
        self.simpleAnswer = simpleAnswer
        self.showTaskButtons = showTaskButtons
    }
    init(lessonNum: Double, directionsText: String, complexAnswer: (String, Int), showTaskButtons: ShowTaskButtons) {
        self.lessonNum = lessonNum
        self.directionsText = directionsText
        self.complexAnswer = complexAnswer
        self.showTaskButtons = showTaskButtons
    }
}

struct ShowTaskButtons {
    var showDirections: Bool = false
    var showSteppers: Bool = false
    var showArm: Bool = false
}
