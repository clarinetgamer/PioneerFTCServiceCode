//
//  PositionHelper.swift
//  SwiftEV3
//
//  Created by Pioneer-Robotics on 1/23/20.
//  Copyright © 2020 Pioneer-Robotics. All rights reserved.
//

import Foundation

struct PositionHelper {
    static func postionForTask(from commands: [Command], position: Position) -> (String, Int) {
        var letterResult = position.letterNum
        var numberResult = position.number
        
        var currentDirection: FacingDirection = .forward
        
        for command in commands {
            switch command.id {
            case .left:
                currentDirection = currentDirection.turnLeft()
            case .right:
                currentDirection = currentDirection.turnRight()
            case .forward:
                switch currentDirection {
                case .left:
                    guard (letterResult > 0 && letterResult < 13) else { continue }
                    letterResult -= 1
                case .right:
                    guard (letterResult > 0 && letterResult < 13) else { continue }
                    letterResult += 1
                case .forward:
                    guard (numberResult > 0 && numberResult < 6) else { continue }
                    numberResult += 1
                case .backwards:
                    guard (numberResult > 0 && numberResult < 6) else { continue }
                    numberResult -= 1
                }
                
            case .backward:
                switch currentDirection {
                case .right:
                    guard (letterResult > 0 && letterResult < 13) else {
                        continue
                    }
                    letterResult -= 1
                case .left:
                    guard (letterResult > 0 && letterResult < 13) else {
                        continue
                    }
                    letterResult += 1
                case .backwards:
                    guard (numberResult > 0 && numberResult < 6) else {
                        continue
                    }
                    numberResult += 1
                case .forward:
                    guard (numberResult > 0 && numberResult < 6) else {
                        continue
                    }
                    numberResult -= 1
                }
                               
            case .armUp, .armDown:
                break
            }
        }
        return (letterResult.associatedLetter, numberResult)
    }

}

struct Position {
    var letterNum: Int
    var number: Int
    
    static var defaultPosition = Position(letterNum: 1, number: 1)
}
