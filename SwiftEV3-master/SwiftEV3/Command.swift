//
//  Command.swift
//  SwiftEV3
//
//  Created by Braden Cantor-Goldner on 11/3/19.
//  Copyright © 2019 CFHS-FTC. All rights reserved.
//

import Foundation


protocol Command {
    var directionText: String { get }
    var runFunction: () -> Void { get }
    var runLength: TimeInterval { get }
}

extension Command {
    var runLength: TimeInterval{
        return 2
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
}
    
struct MoveBackwardCommand: Command {
    var directionText: String {
        return "Move Backward"
    }
    
    var runFunction: () -> Void
    
    init(runFunction: @escaping () -> Void) {
        self.runFunction = runFunction
    }
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
        return 1
    }

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
           return 1
       }
    
}
    

