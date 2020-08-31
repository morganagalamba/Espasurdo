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
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKNode = SKNode()
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var lastUpdateTime : TimeInterval = 0
    private var spinnyNode : SKShapeNode?

    override func sceneDidLoad() {
        ball = self.childNode(withName: "ball")!
        self.lastUpdateTime = 0
        physicsWorld.contactDelegate = self

        update()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("Collison detected")

        if let node = contact.bodyA.node?.name {
            if(node  == "wall"){
                print("bateu")
            }
        }
            
        if let node = contact.bodyB.node?.name {
            
            if(node == "wall"){
                print("bateu")
            }
         }
    }
    
    func update() {
        
       
    }
    
}
