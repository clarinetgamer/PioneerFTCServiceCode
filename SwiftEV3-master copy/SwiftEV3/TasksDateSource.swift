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
        lesson4_2,
        lesson21_1,
        lesson21_2,
        lesson21_3,
        lesson23_1,
        lesson23_2,
        lesson23_3
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
    
    //LESSON 1
    //This is about reaching a target with whole rotations
    static var lesson21_1 = Task(
        lessonNum: 21.1,
    directionsText: "Geronimo the robot is an astronaut traveling through space. Help him reach a new planet which is 3 spaces away.",
    simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
   //This is about reaching a target using half rotations
    static var lesson21_2 = Task(
        lessonNum: 21.2,
        directionsText: "Geronimo the robot is an explorer who needs to cross a bridge over a river to get to the treasure chest. Help him cross the bridge, which is 5 and a half spaces away.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
        //add another half rotation here to make 5.5 rotations
       showTaskButtons:ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    //This is about making the robot go backwards
    static var lesson21_3 = Task(
        lessonNum: 21.3,
    directionsText: "Geronimo is steering a boat across the sea to get one of his parts which he accidentally dropped in the water. First, go to the boat shop to repair his boat, which is 5 spaces in front. Then, make way for other boats to cross in front of him by moving back 2 spaces. Finally, go forward 6 spaces to where Geronimo dropped his part.",
        //robot stops on the blue dot because it goes 9 rotations forward in total
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,
            //add half rotation to make 5.5 rotations
            MoveBackwardCommand.self, MoveBackwardCommand.self,
            //add half rotation to make 2.5 rotations
            MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    
    
    //LESSON 3
    //This is about learning how to turn
    static var lesson23_1 = Task(
        lessonNum: 23.1,
    directionsText: "Geronimo the robot is looking for rocks for his rock collection. Help him find a cool rock, which is 3 spaces in front of him. Then, help him move right 4 spaces to add the rock to his rock pile.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,
            MoveRightCommand.self,
            MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,],
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    //This is about learning to make a U-turn
    static var lesson23_2 = Task(
        lessonNum: 23.2,
    directionsText: "Geronimo the robot has to find ingredients to bake a chocolate cake. Help him get the chocolate, which is 4 spaces away, make a U-turn and come back to where he started.",
        simpleAnswer: [MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,
            MoveRightCommand.self, MoveRightCommand.self,
            //not sure if this is sorrect- the answer key said 1.2
            MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self, MoveForwardCommand.self,],
       
     showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
    
    //This is about combining turns into one path
    static var lesson23_3 = Task(
        lessonNum: 23.3,
    directionsText: "Geronimo the robot has to go to the garden gates to rescue his friend in the palace, but he has to first pass some obstacles on his way. First, help him find a gift for his friend at the store 1 space forward. Then, help him turn right and move 3 spaces forward so that he can find paper to wrap the gift for his friend. Then, help Geronimo turn left and go to the garden gates, which are 2 spaces forward.",
        simpleAnswer: [MoveForwardCommand.self,
        MoveRightCommand.self,
        //for the turn, the answer key said 0.6
        MoveForwardCommand.self, MoveForwardCommand.self,MoveForwardCommand.self,
        //add another half rotation to make 3.5 rotations
        MoveLeftCommand.self,
        //for the turn, the answer key said 0.6
        MoveForwardCommand.self,MoveForwardCommand.self,],
        showTaskButtons: ShowTaskButtons(showDirections: true, showSteppers: true, showArm: true, showSpeed: false))
}
