//
//  AAPLScene.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import SpriteKit

let AAPLCellWidth: CGFloat = 27.0

protocol AAPLSceneDelegate : SKSceneDelegate {
    func didMoveToView(scene: AAPLScene, view: SKView)
}

class AAPLScene: SKScene {
    
    var aaplDelegate: AAPLSceneDelegate?
    
    func pointForGridPosition(position: vector_int2) -> CGPoint {
        return CGPointMake(CGFloat(position.x) * AAPLCellWidth + AAPLCellWidth / 2, CGFloat(position.y) * AAPLCellWidth  + AAPLCellWidth / 2);
    }
    
    override func didMoveToView(view: SKView) {
        aaplDelegate?.didMoveToView(self, view: view)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if let game = aaplDelegate as? AAPLGame {
            game.update(currentTime, forScene: self)
        }
    }
}
