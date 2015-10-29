//
//  AAPLEnemyDefeatedState.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import GameplayKit

class AAPLEnemyDefeatedState: AAPLEnemyState {
    
    var respawnPosition: GKGridGraphNode?
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass == AAPLEnemyRespawnState.self
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        // Change the enemy sprite's appearance to indicate defeat.
        if let component = entity.componentForClass(AAPLSpriteComponent) {
            component.useDefeatedAppearance()
            
            // Use pathfinding to find a route back to this enemy's starting position.
            if let graph = self.game?.level.pathfindingGraph {
                if let enemyNode = graph.nodeAtGridPosition(self.entity.gridPosition) {
                    if let respawnPosition = self.respawnPosition {
                        let path = graph.findPathFromNode(enemyNode, toNode: respawnPosition) as! [GKGridGraphNode]
                        
                        component.followPath(path, completionHandler: { () -> Void in
                            self.stateMachine?.enterState(AAPLEnemyRespawnState)
                        })
                    }
                }
            }
        }
    }
}
