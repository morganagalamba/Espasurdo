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
    var X : Double = -360.0
    var Y : Double = 865.0
    var R : Double = 40.0
    var newX : CGFloat = 0.0
    var newY : CGFloat = 0.0
    var hit: Bool = false
    var hitEnd: Bool = false
    
    var queueX: Queue<CGFloat> = Queue<CGFloat>()
    var queueY: Queue<CGFloat> = Queue<CGFloat>()
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        physicsWorld.contactDelegate = self
        ball = self.childNode(withName: "ball")!

    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        if let node = contact.bodyA.node?.name {
            if(node  == "wall"){
                print("bateu")
                self.isPaused = true
                self.hit = true
            }
        }
            
        if let node = contact.bodyB.node?.name {
            
            if(node == "wall"){
                print("bateu")
                self.isPaused = true
                self.hit = true
            }
         }
        
        if let node = contact.bodyA.node?.name {
            if(node  == "end"){
                print("conseguiu")
                self.hitEnd = true
            }
        }
            
        if let node = contact.bodyB.node?.name {
            
            if(node == "end"){
                print("conseguiu")
                self.hitEnd = true
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
        
        newX = fmin(390, fmax(-390, newX))
        newY = fmin(880, fmax(-816, newY))
        
        self.updateQueue()
        
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
    
    func updateQueue() {
        if queueX.count() == 50 {
            queueX.dequeue()
            queueX.enqueue(self.newX)
            queueY.dequeue()
            queueY.enqueue(self.newX)
        } else {
            queueX.enqueue(self.newX)
            queueY.enqueue(self.newY)
        }
    }
    
    func updateXY() {
        ball.run(SKAction.moveTo(x: queueX.dequeue()!, duration: 2))
        ball.run(SKAction.moveTo(y: -queueY.dequeue()!, duration: 2))
    }
    
    func restart() {
        ball.run(SKAction.moveTo(x: -360, duration: 2))
        ball.run(SKAction.moveTo(y: -(-865), duration: 2))
    }
    
}

// ============ Queue ===============
struct Queue<T> {
    private var elements: [T] = []

    mutating func enqueue(_ value: T) {
        elements.append(value)
    }

    mutating func dequeue() -> T? {
        guard !elements.isEmpty else {
          return nil
        }
        return elements.removeFirst()
    }

    var head: T? {
        return elements.first
    }

    var tail: T? {
        return elements.last
    }
    
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    
    func count() -> Int {
        return elements.count
    }
}
