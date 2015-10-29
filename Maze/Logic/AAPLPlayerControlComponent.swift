//
//  AAPLPlayerControlComponent.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import GameplayKit

enum AAPLPlayerDirection {
    case None, Left, Right, Down, Up
}

class AAPLPlayerControlComponent: GKComponent {
    var level: AAPLLevel
    
    var direction: AAPLPlayerDirection = .None {
        willSet {
            var proposedNode: GKGridGraphNode?
            if self.direction == .None {
                if let nextNode = self.nextNode {
                    proposedNode = self.nodeInDirection(newValue, fromNode: nextNode)
                }
            } else {
                if let entity = self.entity as? AAPLEntity {
                    let currentNode = self.level.pathfindingGraph?.nodeAtGridPosition(entity.gridPosition)
                    proposedNode = self.nodeInDirection(newValue, fromNode: currentNode!)
                }
            }
            
            if proposedNode == nil {
                return
            }
        }
    }
    
    var attemptedDirection: AAPLPlayerDirection = .None
    
    var nextNode: GKGridGraphNode?
    
    init(withLevel level: AAPLLevel) {
        self.level = level
        
        super.init()
    }
    
    func nodeInDirection(direction: AAPLPlayerDirection, fromNode node: GKGridGraphNode) -> GKGridGraphNode? {
        var nextPosition: vector_int2
        switch (direction) {
        case .Left:
            nextPosition = vector_int2(node.gridPosition.x - 1, node.gridPosition.y)
            break
            
        case .Right:
            nextPosition = vector_int2(node.gridPosition.x + 1, node.gridPosition.y)
            break
            
        case .Down:
            nextPosition = vector_int2(node.gridPosition.x, node.gridPosition.y - 1)
            break
            
        case .Up:
            nextPosition = vector_int2(node.gridPosition.x, node.gridPosition.y + 1)
            break
            
        case .None:
            return nil
        }
        
        return level.pathfindingGraph?.nodeAtGridPosition(nextPosition)
    }
    
    func makeNextMove() {
        if let entity = entity as? AAPLEntity {
            let currentNode = level.pathfindingGraph?.nodeAtGridPosition(entity.gridPosition)
            let nextNode = nodeInDirection(direction, fromNode: currentNode!)
            let attemptedNode = nodeInDirection(self.attemptedDirection, fromNode: currentNode!)
            
            if attemptedNode != nil {
                // Move in the attempted direction.
                direction = self.self.attemptedDirection
                self.nextNode = attemptedNode!
                if let component = entity.componentForClass(AAPLSpriteComponent) {
                    component.nextGridPosition = self.nextNode!.gridPosition
                }
            } else if ((attemptedNode == nil) && (nextNode != nil)) {
                // Keep moving in the same direction.
                let dir = self.direction
                self.direction = dir
                self.nextNode = nextNode!
                if let component = entity.componentForClass(AAPLSpriteComponent) {
                    component.nextGridPosition = self.nextNode!.gridPosition
                }
            } else {
                // Can't move any more.
                direction = .None
            }
        }
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        makeNextMove()
    }
}
