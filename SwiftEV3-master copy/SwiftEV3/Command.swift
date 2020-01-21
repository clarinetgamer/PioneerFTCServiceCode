//
//  Command.swift
//  SwiftEV3
//
//  Created by CFHS-FTC on 11/3/19.
//  Copyright © 2019 CFHS-FTC. All rights reserved.
//

import Foundation


protocol Command {
    var directionText: String { get }
    var runFunction: () -> Void { get }
    var runLength: TimeInterval { get }
    var id: CommandId { get }
}

enum CommandId {
    case left, right, forward, backward, armUp, armDown
}

extension Command {
    var runLength: TimeInterval{
        return 3
    }
}

struct MoveForwardCommand: Command {
    var directionText: String {
        return "Move Forward"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
    
    var id: CommandId = .forward
}

struct MoveBackwardCommand: Command {
    var directionText: String {
        return "Move Backward"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
    var id: CommandId = .backward

}
struct MoveLeftCommand: Command {
    var directionText: String {
        return "Move Left"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
    
    var runLength: TimeInterval{
        return 2
    }
    var id: CommandId = .left

}

struct MoveRightCommand: Command {
    var directionText: String {
        return "Move Right"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
    
    var runLength: TimeInterval{
        return 2
    }
    var id: CommandId = .right

}
struct ArmUpCommand: Command {
    var directionText: String {
        return "Arm Up"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
    
    var runLength: TimeInterval{
        return 2
    }
    var id: CommandId = .armUp

}

struct ArmDownCommand: Command {
    var directionText: String {
        return "Arm Down"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
    
    var runLength: TimeInterval{
        return 2
    }
    var id: CommandId = .armDown

}

