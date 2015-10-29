//
//  AAPLSpriteComponent.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import GameplayKit
import SpriteKit

class AAPLSpriteComponent: GKComponent {
    var sprite: AAPLSpriteNode?
    var defaultColor: SKColor
    
    var pulseEffectEnabled: Bool = false {
        didSet {
            if (pulseEffectEnabled) {
                let grow = SKAction.scaleBy(1.5, duration: 0.5)
                let sequence = SKAction.sequence([grow, grow.reversedAction()])
                
                sprite?.runAction(SKAction.repeatActionForever(sequence), withKey: "pulse")
            } else {
                sprite?.removeActionForKey("pulse")
                sprite?.runAction(SKAction.scaleTo(1.0, duration: 0.5))
            }
        }
    }
    
    var nextGridPosition: vector_int2 = vector_int2(0, 0) {
        willSet {
            if (self.nextGridPosition.x != newValue.x || self.nextGridPosition.y != newValue.y) {
//                self.nextGridPosition = newValue
                
                if let scene = sprite?.scene as? AAPLScene {
                    let action = SKAction.moveTo(scene.pointForGridPosition(nextGridPosition), duration: 0.35)
                    let update = SKAction.runBlock({ () -> Void in
                        if let entity = self.entity as? AAPLEntity {
                            entity.gridPosition = self.self.nextGridPosition
                        }
                    })
                    
                    sprite?.runAction(SKAction.sequence([action, update]), withKey: "move")
                }
            }
        }
    }
    
    init(withDefaultColor defaultColor: SKColor) {
        self.defaultColor = defaultColor
        
        super.init()
    }
    
    func useNormalAppearance() {
        sprite?.color = defaultColor
    }
    
    func useFleeAppearance() {
        sprite?.color = SKColor.whiteColor()
    }
    
    func useDefeatedAppearance() {
        sprite?.runAction(SKAction.scaleTo(0.25, duration: 0.25))
    }
    
    func warpToGridPosition(gridPosition: vector_int2) {
        if let scene = sprite?.scene as? AAPLScene {
            let fadeOut = SKAction.fadeOutWithDuration(0.5)
            let warp = SKAction.moveTo(scene.pointForGridPosition(gridPosition), duration: 0.5)
            let fadeIn = SKAction.fadeInWithDuration(0.5)
            let update = SKAction.runBlock({ () -> Void in
                if let entity = self.entity as? AAPLEntity {
                    entity.gridPosition = gridPosition
                }
            })
            
            sprite?.runAction(SKAction.sequence([fadeOut, update, warp, fadeIn]))
        }
    }
    
    func followPath(path: [GKGridGraphNode], completionHandler: (() -> Void)) {
        // Ignore the first node in the path -- it's the starting position.
        let dropFirst = path[1..<path.count]
        var sequence: [SKAction] = []
        
        for node in dropFirst {
            if let scene = sprite?.scene as? AAPLScene {
                let point = scene.pointForGridPosition(node.gridPosition)
                sequence.append(SKAction.moveTo(point, duration: 0.15))
                sequence.append(SKAction.runBlock({ () -> Void in
                    if let entity = self.entity as? AAPLEntity {
                        entity.gridPosition = node.gridPosition
                    }
                }))
            }
            
            sequence.append(SKAction.runBlock(completionHandler))
            sprite?.runAction(SKAction.sequence(sequence))
        }
    }
}

