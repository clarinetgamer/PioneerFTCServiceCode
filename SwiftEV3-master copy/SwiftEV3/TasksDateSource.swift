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
        lesson3_3,
        lesson4_1,
        lesson4_2
    ]
    
    static var lesson1 = Task(
        lessonNum: 1,
        directionsText: "Practice Connecting To The Robot. You can do this by pressing the connect button.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        showTaskButtons: ShowTaskButtons(showDirections: false, showSteppers: false, showArm: false, showSpeed: true),
        speed: 0.25)

    static var lesson2 = Task(
        lessonNum: 2,
        directionsText: "Geronimo the robot is a pirate collecting treasure. He starts at the point A1 on a grid. Go and collect the missing pirate treasure located at E4 on the grid.",
        complexAnswer: [("E", 4)],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: false, showArm: false, showSpeed: false))
    
    static var lesson2_1 = Task(
        lessonNum: 2.1,
        directionsText: "Geronimo the robot is a pirate collecting treasure. He starts at the point A1 on a grid. Go and collect the missing pirate treasure. Choose a spot to hide the tresure and then help Geronimo find it.",
        complexAnswer: [("A", 1)],
        askUserForEndPosition: true,
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: false, showArm: false, showSpeed: false))
    
    static var lesson3 = Task(
        lessonNum: 3,
        directionsText: "Geronimo the robot is an ant who needs help finding his way back to his house at the ant hill. He starts at A5 on the grid. The ant hill is located at L3, L1, or L5. Please choose one point to help him find his way back home.",
        complexAnswer: [("L", 3), ("L", 1), ("L", 5)],
        position: Position(letterNum: 1, number: 5),
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: false, showSpeed: false))
    
    static var lesson3_1 = Task(
        lessonNum: 3.1,
        directionsText: "Geronimo the robot is an ant who needs help finding his way to the nursery. He currently is at L1 on the grid. The nursery is located at F4 or G4. Please choose one point to help him find his way to the nursery.",
        complexAnswer: [("F", 4), ("G", 4)],
        position: Position(letterNum: 12, number: 1),
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: false, showSpeed: false))
    
    static var lesson3_2 = Task(
        lessonNum: 3.2,
        directionsText: "Geronimo the robot is an ant who needs help finding his way to the Queen. The Queen is located at F2, F3, G2, or G3. He currently is at L1 on the grid. Please choose one point to help him find his way to the Queen",
        complexAnswer: [("F", 2), ("F", 3), ("G", 2), ("G", 3)],
        position: Position(letterNum: 12, number: 1),
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var lesson3_3 = Task(
        lessonNum: 3.3,
        directionsText: "Geronimo the robot is an ant who needs help finding his way to the farm. The farm is located at B4 or K4.  He currently is at L1 on the grid. Please choose one point to help him find his way to the farm ",
        complexAnswer: [("B", 4), ("K", 4)],
        position: Position(letterNum: 12, number: 1),
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    // The answer isn't correct I'm just adding it in so we can work on it later. There will be use of the arm here not in lessons 3.
    static var lesson4_1 = Task(
      lessonNum: 4.1,
      directionsText: "Geronimo the robot is a waiter who is serving water to a table of guests.(Answer not currently correct)",
      complexAnswer: [("B", 4), ("K", 4)],
      position: Position(letterNum: 12, number: 1),
      showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))

    // The answer isn't correct I'm just adding it in so we can work on it later.There will be use of the arm here not in lessons 3. 
    static var lesson4_2 = Task(
      lessonNum: 4.2,
      directionsText: "Geronimo the robot is a waiter who is serving food to a table of guests.(Answer not currently correct)",
      complexAnswer: [("B", 4), ("K", 4)],
      position: Position(letterNum: 12, number: 1),
      showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
/* Name Scheme:   lesson(year if greater than 1)(lesson #)_(part#) Year Ex:lesson2y1_1
  Lesson Assignments
     Mallika Lesson 1
     Henry Lesson 2
     Seth Lesson 2 Bonus
     Mallika Lesson 3
     Henry Lesson 4
     Seth Lesson 5
    */
    //Write code here \/
    
    //This is all task 1 lesson 2 on the worksheet \/
    static var Lesson21_1 = Task(
        lessonNum: 21.1,
    directionsText: "Geronimo the robot needs to reach the dot targets. Find out how many rotations it takes to get to the yellow dot.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson21_2 = Task(
        lessonNum: 21.2,
    directionsText: "Geronimo the robot needs to reach the dot targets. Find out how many rotations it takes to get to the red dot.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson21_3 = Task(
        lessonNum: 21.3,
    directionsText: "Geronimo the robot needs to reach the dot targets. Find out how many rotations it takes to get to the blue dot.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
   //This is all task 2 lesson 2 on the worksheet \/
    static var Lesson22_1 = Task(
        lessonNum: 22.1,
        directionsText: "Geronimo the robot needs to reach the line targets. Find out how many rotations it takes to get to the first line.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        //add another half rotation here to make 5.5 rotations
       showTaskButtons:ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson22_2 = Task(
        lessonNum: 22.2,
    directionsText: "Geronimo the robot needs to reach the dot targets. Find out how many rotations it takes to get to the second line.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        //add another half rotation here to make 5.5 rotations
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    //This is all task 3 lesson 2 on the worksheet \/
    static var Lesson23_1 = Task(
        lessonNum: 23.1,
    directionsText: "Geronimo the robot needs to cross the table. Find out how many rotations it takes for it to go the width, or short distance, of the table.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        //add another part rotation here to make 5.3 rotations
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson23_2 = Task(
        lessonNum: 23.2,
    directionsText: "Geronimo the robot needs to cross the table. Find out how many rotations it takes for it to go the legnth, or long distance, of the table.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        //add another half rotation here to make 12.5 rotations
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    //This is all task 4 lesson 2\/
    static var Lesson24_1 = Task(
        lessonNum: 24.1,
    directionsText: "Try out the code on Geronimo and write down the color of the dot it lands on.",
        //robot stops on the blue dot because it goes 9 rotations forward in total
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,
            //add half rotation to make 5.5 rotations
            MoveBackwardCommand.self, MoveBackwardCommand.self,
            //add half rotation to make 2.5 rotations
            MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    //This is all task 5 on the worksheet lesson 2\/
    static var Lesson25_1 = Task(
        lessonNum: 25.1,
    directionsText: "Try out the code on Geronimo and write down which line it lands on.",
        //robot stops on the first line because it goes 5.5 rotations forward in total
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,
            MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,
            //add half rotation to make 4.5 rotations
            MoveBackwardCommand.self, MoveBackwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    
    
    //This is all task 1 lesson 3 on the worksheet \/
    static var Lesson31_1 = Task(
        lessonNum: 31.1,
    directionsText: "Try out the code on Geronimo. Go to the first blue line.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,MoveForwardCommand.self, MoveForwardCommand.self, ],
        //add another half rotation to make 5.5 rotations
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson31_2 = Task(
        lessonNum: 31.2,
    directionsText: "Try out the code on Geronimo. Turn right.",
        simpleAnswer: [MoveRightCommand.self],
        //not sure if this is correct- the answer key said F0.6
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson31_3 = Task(
        lessonNum: 31.3,
    directionsText: "Try out the code on Geronimo. Go to stop.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self,],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    //This is all task 2 lesson 3 on the worksheet \/
    static var Lesson32_1 = Task(
        lessonNum: 32.1,
    directionsText: "Make Geronimo the robot go to the second blue line.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,],
        //add another half rotation here to make 7.5 rotations
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson32_2 = Task(
        lessonNum: 32.2,
    directionsText: "Make Geronimo the robot turn left.",
        simpleAnswer: [MoveLeftCommand.self],
        //not sure if this is correct- the answer key said F0.6
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    static var Lesson32_3 = Task(
        lessonNum: 32.3,
    directionsText: "Make Geronimo the robot go to stop.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self,],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    //This is all task 3 lesson 3 on the worksheet \/
    
    

}
