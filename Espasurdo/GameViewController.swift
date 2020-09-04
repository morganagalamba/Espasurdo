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


class GameViewController: UIViewController {
    
    let scene = GKScene(fileNamed: "GameScene")
    var sceneNode: GameScene? = nil

    var timer = Timer()
    let nextViewController = ProximityViewController()
    var timerMusic = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "hitSensor")
        
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "backgroundMusic")
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        self.sceneNode = scene!.rootNode as! GameScene?
        
        sceneNode!.entities = scene!.entities
        sceneNode!.graphs = scene!.graphs
        
        // Set the scale mode to scale to fit the window
        sceneNode!.scaleMode = .aspectFill
        
        // Present the scene
        if let view = self.view as! SKView? {
            view.presentScene(sceneNode)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        self.startObserve()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "backgroundMusic")
        //print("Entrou viewDidAppear")
        print("estado do hitSensor")
        print(UserDefaults.standard.bool(forKey: "hitSensor"))
        self.startObserve()
        if UserDefaults.standard.bool(forKey: "hitSensor") == true {
            
            UserDefaults.standard.set(false, forKey: "hitSensor")
            //self.startObserve()
            self.sceneNode?.isPaused = false
            self.sceneNode?.updateXY()
        } else {
            UserDefaults.standard.set(false, forKey: "hitSensor")
            //self.startObserve()
            self.sceneNode?.isPaused = false
            self.sceneNode?.restart()
        }
    }
    
    func startObserve () {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.checksStatusHit)), userInfo: nil, repeats: true)
        
    }
    
    @objc func checksStatusHit() {
        
        //print(sceneNode?.hit)
        
        if sceneNode?.hit != false {
            
            self.sceneNode?.hit = false
            sceneNode?.isPaused = true
            timer.invalidate()
            //self.navigationController?.show(proximityViewController(), sender: nil)
            //self.show(self.nextViewController, sender: nil)
            //self.navigationController?.
            //show(self.nextViewController, sender: nil)
            
            //self.show(nextVC, sender: nil)
            
            //self.present(nextVC, animated: true, completion: nil)
            MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "impact")
            
            timerMusic = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.changeScreen), userInfo: nil, repeats: false)
        }
        
        if sceneNode?.hitEnd != false {
            self.sceneNode?.hitEnd = false
            timer.invalidate()
            sceneNode?.isPaused = true
            //self.navigationController?.show(proximityViewController(), sender: nil)
            //self.show(self.nextViewController, sender: nil)
            //self.navigationController?.
            //show(self.nextViewController, sender: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(identifier: "apiData") as! ApiDataViewController
            
            //self.show(nextVC, sender: nil)
            
            //self.present(nextVC, animated: true, completion: nil)
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            
            //self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    @objc func changeScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextVC = storyboard.instantiateViewController(identifier: "proximity") as! ProximityViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func restart(){
        
        if let view = self.view as! SKView? {
            let scene = SKScene(fileNamed: "GameScene")!
            sceneNode = scene as! GameScene
            //sceneNode.scaleMode = .aspectFill
            view.presentScene(sceneNode)
            view.ignoresSiblingOrder = false
            //view.showsPhysics = true
            
            self.sceneNode = sceneNode!
        }
    }

}
