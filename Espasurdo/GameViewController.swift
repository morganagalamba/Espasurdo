//
//  GameViewController.swift
//  labritinto
//
//  Created by Morgana Beatriz on 28/08/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

class GameViewController: UIViewController {
    
    var sceneNode = GameScene()
    var timer: Timer!
    let motionManager = CMMotionManager()
    var X : CGFloat = 640.0
    var Y : CGFloat = 640.0
    var R : CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        }
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(GameViewController.update), userInfo: nil, repeats: true)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
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
        }
        
        //sceneNode.ball.run(SKAction.moveTo(x: X , duration: 1)
        //sceneNode.ball.run(SKAction.moveTo(y: Y , duration: 1))
    }
}
