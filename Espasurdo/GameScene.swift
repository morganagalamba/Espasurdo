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
    let deviceAttitude = CMAttitude()
    private var lastUpdateTime : TimeInterval = 0
    private var spinnyNode : SKShapeNode?
    var X : Double = 0.0
    var Y : Double = 0.0
    var R : Double = 40.0
    
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        physicsWorld.contactDelegate = self
        ball = self.childNode(withName: "ball")!
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()

    }
    
    func didBegin(_ contact: SKPhysicsContact) {

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
    
    override func update(_ currentTime: TimeInterval) {
        /*if let accelerometerData = motionManager.accelerometerData {
            print("foi 1")
            print(accelerometerData)
        }
        if let gyroData = motionManager.gyroData {
            print("foi 2")
            print(gyroData)
        }
        if let magnetometerData = motionManager.magnetometerData {
            print("foi 3")
            print(magnetometerData)
        }
        if let deviceMotion = motionManager.deviceMotion {
            print("foi 4")
            print(deviceMotion)
        }*/
        
        //X = X + (2 * deviceAttitude.roll)
        //Y = Y + (2 * deviceAttitude.pitch)
        //print(deviceAttitude.yaw)
        //print(deviceAttitude.pitch)
        /*X *= 0.8
        Y *= 0.8
        
        var newX : CGFloat  = 3.0
        var newY : CGFloat  = 3.0
          
       newX = fmin(280, fmax(0, newX))
       newY = fmin(527, fmax(64, newY))
        
        */
        ball.run(SKAction.moveTo(x:2.0, duration: 1))
        ball.run(SKAction.moveTo(y: 2.0 , duration: 1))
        
    }
    
    

    
}
