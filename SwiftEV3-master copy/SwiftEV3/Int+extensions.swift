//
//  Int+extensions.swift
//  SwiftEV3
//
//  Created by Pioneer-Robotics on 1/23/20.
//  Copyright © 2020 Pioneer-Robotics. All rights reserved.
//

import Foundation

extension Int {
    var associatedLetter: String {
        switch self {
        case 1: return "A"
        case 2: return "B"
        case 3: return "C"
        case 4: return "D"
        case 5: return "E"
        case 6: return "F"
        case 7: return "G"
        case 8: return "H"
        case 9: return "I"
        case 10: return "J"
        case 11: return "K"
        case 12: return "L"
            
        default:
            fatalError("This shouldn't happen...")
        }
        
    }
}
