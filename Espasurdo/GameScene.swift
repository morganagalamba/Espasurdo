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
    let motionManager = CMMotionManager()
    private var lastUpdateTime : TimeInterval = 0
    private var spinnyNode : SKShapeNode?
    var timer : Timer!
    var X : Double = 0.0
    var Y : Double = 0.0
    var R : Double = 40.0
    var newX : CGFloat = 0.0
    var newY : CGFloat = 0.0
   var bateu = false
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        physicsWorld.contactDelegate = self
        ball = self.childNode(withName: "ball")!

    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        if let node = contact.bodyA.node?.name {
            if(node  == "wall"){
                print("bateu")
                self.bateu = true
            }
        }
            
        if let node = contact.bodyB.node?.name {
            
            if(node == "wall"){
                print("bateu")
                self.bateu = true
            }
         }
        
        if let node = contact.bodyA.node?.name {
            if(node  == "end"){
                print("conseguiu")
            }
        }
            
        if let node = contact.bodyB.node?.name {
            
            if(node == "end"){
                print("conseguiu")
            }
         }
    }
    
    func updateBall(_ roll: Double,_ pitch : Double){
       X = X + (2 * roll)
       Y = Y + (2 * pitch)
        
        X *= 0.8
        Y *= 0.8
        
        
        newX = newX + CGFloat(X)
        newY = newY + CGFloat(Y)
           
        newX = fmin(320, fmax(-320, newX))
        newY = fmin(640, fmax(-640, newY))

        ball.run(SKAction.moveTo(x: newX, duration: 0.2))
        ball.run(SKAction.moveTo(y: -newY, duration: 0.2))
        
       
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        var pitch: Double = -590.0
        var roll: Double = -300.0
        
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        self.motionManager.showsDeviceMovementDisplay = true
        self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
       
        if let data = self.motionManager.deviceMotion{
            pitch = data.attitude.pitch
            roll = data.attitude.roll
            updateBall(roll, pitch)
        }
        
        
    }
    
    

    
}
