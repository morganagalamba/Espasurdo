//
//  Player.swift
//  Espasurdo
//
//  Created by José Henrique Fernandes Silva on 04/09/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import Foundation
import AVFoundation

public class Player {
    
    public var musicPlayer: AVAudioPlayer?
    
    var player = AVAudioPlayer()
    
    var musicName: String = ""
    
    public init(musicName:String) {
        self.musicName = musicName
    }
    
    public func createPlayer() -> AVAudioPlayer? {
        print("Criando")
        guard let url = Bundle.main.url(forResource: self.musicName, withExtension: "mp3") else {
            return nil
        }
        
        do {
            try player = AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch {
            print("Error loading \(url.absoluteString): \(error)")
        }
        
        return player
    }
    
    public func startMusic() {
        print("Tocando")
        let create = createPlayer()
        create?.numberOfLoops = 10
        create?.play()
        
    }
    
}
