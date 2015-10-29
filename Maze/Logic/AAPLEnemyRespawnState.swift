//
//  AAPLEnemyRespawnState.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import GameplayKit

class AAPLEnemyRespawnState: AAPLEnemyState {

    var timeRemaining: NSTimeInterval = 10
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == AAPLEnemyChaseState.self
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        timeRemaining = 10
        
        if let component = entity.componentForClass(AAPLSpriteComponent) {
            component.pulseEffectEnabled = true
        }
    }
    
    override func willExitWithNextState(nextState: GKState) {
        if let component = entity.componentForClass(AAPLSpriteComponent) {
            component.pulseEffectEnabled = false
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        self.timeRemaining -= seconds
        if self.timeRemaining < 0 {
            stateMachine?.enterState(AAPLEnemyChaseState)
        }
    }
}
