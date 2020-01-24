//
//  FacingDirection.swift
//  SwiftEV3
//
//  Created by Gregg Goldner on 1/23/20.
//  Copyright © 2020 謝飛飛. All rights reserved.
//

import Foundation

enum FacingDirection {
    case left, right, forward, backwards
    
    func turnLeft() -> FacingDirection {
        switch self {
        case .left: return .backwards
        case .right: return .forward
        case .forward: return .left
        case .backwards: return .right
        }
    }
    
    func turnRight() -> FacingDirection {
        switch self {
        case .left: return .forward
        case .right: return .backwards
        case .forward: return .right
        case .backwards: return .left
        }
    }

}
