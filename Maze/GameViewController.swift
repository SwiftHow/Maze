//
//  GameViewController.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright (c) 2015年 SWIFT.HOW. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var game: AAPLGame?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the game and its SpriteKit scene.
        game = AAPLGame()
        if let scene = game?.scene {
            scene.scaleMode = .AspectFit
            
            // Present the scene and configure the SpriteKit view.
            let skView = self.view as! SKView
            skView.presentScene(scene)
            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
    }
    
    @IBAction func swipeUp(sender: AnyObject) {
        game?.playerDirection = .Up
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        game?.playerDirection = .Right
    }
    
    @IBAction func swipeDown(sender: AnyObject) {
        game?.playerDirection = .Down
    }
    
    @IBAction func swipeLeft(sender: AnyObject) {
        game?.playerDirection = .Left
    }
    
    @IBAction func tap(sender: AnyObject) {
        game?.hasPowerup = true
    }
    
}
