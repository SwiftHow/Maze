//
//  AAPLEnemyState.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import GameplayKit

class AAPLEnemyState: GKState {
    
    weak var game: AAPLGame?
    
    var entity: AAPLEntity
    
    init(withGame game: AAPLGame, entity: AAPLEntity) {
        self.game = game
        self.entity = entity
        
        super.init()
    }
    
    func pathToNode(node: GKGridGraphNode) -> [GKGridGraphNode] {
        if let graph = game?.level.pathfindingGraph {
            if let enemyNode = graph.nodeAtGridPosition(entity.gridPosition) {
                return graph.findPathFromNode(enemyNode, toNode: node) as! [GKGridGraphNode]
            }
        }
        
        return []
    }
    
    func startFollowingPath(path: [GKGridGraphNode]) {
        /*
            Set up a move to the first node on the path, but
            no farther because the next update will recalculate the path.
        */
        
        if path.count > 1 {
            let firstMove = path[1]
            if let component = entity.componentForClass(AAPLSpriteComponent) {
                component.nextGridPosition = firstMove.gridPosition
            }
        }
    }
}
