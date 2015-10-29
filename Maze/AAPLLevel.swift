//
//  AAPLLevel.swift
//  Maze
//
//  Created by Wayne on 15/10/28.
//  Copyright © 2015年 SWIFT.HOW. All rights reserved.
//

import GameplayKit

enum TileType: Int {
    case Open = 0
    case Wall = 1
    case Portal = 2
    case Start = 3
}

let AAPLMazeWidth: Int = 32
let AAPLMazeHeight: Int = 28
let Maze: [Int] = [
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
    1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,1,0,1,
    1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,
    1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,
    1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,
    1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,1,1,
    1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,1,
    1,0,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,0,1,
    1,0,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,0,1,
    1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,0,3,4,0,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,0,1,1,0,1,
    1,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,1,
    1,1,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,
    1,1,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1,1,0,1,1,1,1,
    1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,
    1,0,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,0,1,
    1,0,1,1,1,1,1,1,1,0,1,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,0,1,
    1,0,0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,1,
    1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,
    1,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,1,0,1,1,0,1,1,1,1,0,1,
    1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,1,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
]

class AAPLLevel: NSObject {
    
    var startPosition: GKGridGraphNode?
    var enemyStartPositions: [GKGridGraphNode]?
    var pathfindingGraph: GKGridGraph?
    
    var width: Int {
        get {
            return AAPLMazeWidth
        }
    }
    
    var height: Int {
        get {
            return AAPLMazeHeight
        }
    }
    
    override init() {
        super.init()
        
        let graph = GKGridGraph(fromGridStartingAt: vector_int2(0, 0), width: Int32(AAPLMazeWidth), height: Int32(AAPLMazeHeight), diagonalsAllowed: false)
        var wall: [GKGridGraphNode] = []
        var spawnPoints: [GKGridGraphNode] = []
        for i in 0..<AAPLMazeWidth {
            for j in 0..<AAPLMazeHeight {
                let tile = tileAtRole(i, column: j)
                if tile == TileType.Wall.rawValue {
                    wall.append(graph.nodeAtGridPosition(vector_int2(Int32(i), Int32(j)))!)
                } else if tile == TileType.Portal.rawValue {
                    spawnPoints.append(graph.nodeAtGridPosition(vector_int2(Int32(i), Int32(j)))!)
                } else if tile == TileType.Start.rawValue {
                    startPosition = graph.nodeAtGridPosition(vector_int2(Int32(i), Int32(j)))!
                }
            }
        }
        
        graph.removeNodes(wall)
        
        enemyStartPositions = spawnPoints
        
        pathfindingGraph = graph
    }
    
    func tileAtRole(row: Int, column col: Int) -> Int {
        return Maze[row * AAPLMazeHeight + col]
    }
}
