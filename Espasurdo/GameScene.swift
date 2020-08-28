//
//  GameScene.swift
//  labritinto
//
//  Created by Morgana Beatriz on 28/08/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
    }
    
    /*if let node = contact.bodyA.node?.name as! String? {
        if(node  == "wall"){
            print("bateu")
        }

    }
        
    if let node = contact.bodyB.node?.name as! String?{
        
        if(node == "wall"){
            print("bateu")
        }
     }*/
    
}
