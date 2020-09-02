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
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        physicsWorld.contactDelegate = self
        ball = self.childNode(withName: "ball")!
        
        

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
    
    func updateBall(_ roll: Double,_ pitch : Double,_ accZ: Double){
       X = X + (2 * roll)
       Y = Y + (2 * pitch)
        
        X *= 0.8
        Y *= 0.8
        
        
        newX = newX + CGFloat(X)
        newY = newY + CGFloat(Y)
           
        newX = fmin(320, fmax(-320, newX))
        newY = fmin(640, fmax(-640, newY))
        
        let newR : CGFloat = CGFloat(R + 10 * accZ)
        //print("x:")
        //print(newX)
        //print("y:")
        //print(newY)
        //print("R:")
        //print(TimeInterval(newR))
        //ball.run(SKAction.moveTo(x: newX, y: newY, duration: 0.2))
        ball.run(SKAction.moveTo(x: newX, duration: 1.0))
        ball.run(SKAction.moveTo(y: -newY, duration: 1.0))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        var pitch: Double!
        var roll: Double!
        var yaw: Double!
        var accZ : Double!
        
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motionManager.showsDeviceMovementDisplay = true
            self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motionManager.startAccelerometerUpdates()
            
            // Configure a timer to fetch the motion data.
            self.timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                            block: { (timer) in
                                if let data = self.motionManager.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
                                   pitch = data.attitude.pitch
                                   roll = data.attitude.roll
                                   //yaw = data.attitude.yaw
                                    let data = self.motionManager.accelerometerData
                                    accZ = data?.acceleration.z
                                    self.updateBall(roll, pitch,accZ)
                                    // Use the motion data in your app.
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
        
        /*if self.motionManager.isAccelerometerAvailable {
           self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
           self.motionManager.startAccelerometerUpdates()

           // Configure a timer to fetch the data.
           self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                 repeats: true, block: { (timer) in
              // Get the accelerometer data.
              if let data = self.motionManager.accelerometerData {
                 accZ = data.acceleration.z

                 // Use the accelerometer data in your app.
              }
           })

           // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }*/
        
        //updateBall(roll, pitch)
        
    }
    
    

    
}
