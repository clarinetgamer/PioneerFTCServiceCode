//
//  TasksDateSource.swift
//  SwiftEV3
//
//  Created by Pioneer-Robotics on 1/23/20.
//  Copyright © 2020 Pioneer-Robotics. All rights reserved.
//

import Foundation

struct TaskDateSource {
    static var allTasks: [Task] = [
        lesson1,
        lesson2,
        lesson2_1,
        lesson3,
        lesson3_1,
        lesson3_2,
        lesson3_3
    ]
    
    static var lesson1 = Task(
        lessonNum: 1,
        directionsText: "Geronimo the robot is stuck out on a bridge! Add the Move Forward Command 3 times to drive your robot out and save him.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        showTaskButtons: ShowTaskButtons(showDirections: false, showSteppers: false, showArm: false))
    
    static var lesson2 = Task(
        lessonNum: 2,
        directionsText: "Geronimo the robot is a pirate collecting treasure. He starts at the point A1 on a grid. Go and collect the missing pirate treasure located at E4 on the grid.",
        complexAnswer: [("E", 4)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: false, showArm: false))
    
    static var lesson2_1 = Task(
        lessonNum: 2.1,
        directionsText: "Geronimo the robot is a pirate collecting treasure. He starts at the point A1 on a grid. Go and collect the missing pirate treasure. Choose a spot to hide the tresure and then help Geronimo find it.",
        complexAnswer: [("A", 1)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: false, showArm: false))
    
    static var lesson3 = Task(
        lessonNum: 3,
        directionsText: " ",
        complexAnswer: [("L", 3), ("L", 1), ("L", 5)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: false))
    
    static var lesson3_1 = Task(
        lessonNum: 3.1,
        directionsText: " ",
        complexAnswer: [("A", 1)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: false))
    
    static var lesson3_2 = Task(
        lessonNum: 3.2,
        directionsText: " ",
        complexAnswer: [("A", 1)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true))
    
    static var lesson3_3 = Task(
        lessonNum: 3.3,
        directionsText: " ",
        complexAnswer: [("A", 1)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true))
}
