//
//  AAPLGame.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import SpriteKit
import GameplayKit

class AAPLGame: NSObject, AAPLSceneDelegate, SKPhysicsContactDelegate {
    
    private var _scene: AAPLScene?
    
    var level: AAPLLevel!
    
    var enemies: [AAPLEntity]
    
    var player: AAPLEntity
    
    var intelligenceSystem: GKComponentSystem
    
    var playerDirection: AAPLPlayerDirection = .None {
        didSet {
            
        }
    }
    
    var hasPowerup: Bool = false {
        didSet {
            
        }
    }
    
    var random: GKRandomSource
    
    override init() {
        random = GKRandomSource()
        level = AAPLLevel()
        
        // Create player entity with display and control component.
        player = AAPLEntity()
        player.addComponent(AAPLSpriteComponent())
        player.addComponent(AAPLPlayerControlComponent())
        
        // Create enemy entities with display and AI components.
//        let colors = [SKColor.redColor(), SKColor.greenColor(), SKColor.yellowColor(), SKColor.magentaColor()]
        intelligenceSystem = GKComponentSystem(componentClass: AAPLIntelligenceComponent.self)
        
        enemies = []
        super.init()
    }
    
    var scene: SKScene {
        get {
            if _scene == nil {
                _scene = AAPLScene(size: CGSizeMake(CGFloat(level.width) * AAPLCellWidth, CGFloat(level.height) * AAPLCellWidth))
                
                _scene!.aaplDelegate = self
                _scene!.physicsWorld.gravity = CGVectorMake(0, 0)
                _scene!.physicsWorld.contactDelegate = self
            }
            
            return _scene!
        }
    }
    
    func didMoveToView(scene: AAPLScene, view: SKView) {
        scene.backgroundColor = SKColor.blackColor()
        
        // Generate maze.
        let maze = SKNode()
        let cellSize = CGSizeMake(AAPLCellWidth, AAPLCellWidth);
        
        if let graph = level.pathfindingGraph {
            for i in 0..<level.width {
                for j in 0..<level.height {
                    if graph.nodeAtGridPosition(vector_int2(Int32(i), Int32(j))) != nil {
                        // Make nodes for traversable areas; leave walls as background color.
                        let node = SKSpriteNode(color: SKColor.grayColor(), size: cellSize)
                        node.position = CGPointMake(CGFloat(i) * AAPLCellWidth + AAPLCellWidth / 2, CGFloat(j) * AAPLCellWidth  + AAPLCellWidth / 2)
                        maze.addChild(node)
                    }
                }
            }
        }
        
        scene.addChild(maze)
        
        // Add player entity to scene.
    }
}
