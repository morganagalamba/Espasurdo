
//
//  proximityViewController.swift
//  Espasurdo
//
//  Created by José Henrique Fernandes Silva on 01/09/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//
import UIKit

class ProximityViewController: UIViewController {


    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    var device = UIDevice.current
    var timer = Timer()
    var timeCounter = 500
    var sensorTimer = Timer()
    var timerMusic = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "impact")
        counterLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        timerMusic = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.changeMusic), userInfo: nil, repeats: false)
        
    }
    
    @objc func changeMusic() {
        MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "proximityBackground")
    }

    @IBAction func startTapped(_ sender: Any) {
        startObserve()
        DispatchQueue.main.async {
            self.device.isProximityMonitoringEnabled = true
        }
        self.startButton.isEnabled = false
    }

    func startObserve () {
        NotificationCenter.default.addObserver(self, selector: #selector(self.verifyProximityState), name: UIDevice.proximityStateDidChangeNotification, object: nil)
        //sensorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(self.verifyProximityState)), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(self.updateCounterLabel)), userInfo: nil, repeats: true)
    }

    @objc func verifyProximityState() {

      
            //if (device.proximityState == true) {

                self.updateCounterLabel()
                // Para de ficar chamando a função
                timer.invalidate()
                sensorTimer.invalidate()
                // Para de monitorar o proximity state
                device.isProximityMonitoringEnabled = false
                // Verifica se conseguiu parar a tempo
                if self.timeCounter <= 30 && self.timeCounter >= 0 {
                    UserDefaults.standard.set(true, forKey: "hitSensor")
                    print("nkjlwqhfnwieohwhio")
                }
                //print(self.isBeingDismissed)
                //dismiss(animated: true, completion: nil)
                NotificationCenter.default.removeObserver(self, name:UIDevice.proximityStateDidChangeNotification, object: nil)
                self.navigationController?.popViewController(animated: false)
                
                //self.navigationController?.dismiss(animated: true, completion: nil)
                
                //print(self.isBeingDismissed)
            
            //}
        
        
    }

    @objc func updateCounterLabel () {
        self.timeCounter -= 1
        if self.timeCounter <= 30 && self.timeCounter >= 0 {
            counterLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else {
            counterLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        counterLabel.text = String(timeCounter)
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
