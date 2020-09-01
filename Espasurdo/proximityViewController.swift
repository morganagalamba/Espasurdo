//
//  proximityViewController.swift
//  Espasurdo
//
//  Created by José Henrique Fernandes Silva on 01/09/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import UIKit

class proximityViewController: UIViewController {

    
    @IBOutlet weak var counterLabel: UILabel!
    
    var device = UIDevice.current
    var timer = Timer()
    var timeCounter = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    @IBAction func startTapped(_ sender: Any) {
        startObserve()
        device.isProximityMonitoringEnabled = true
    }
    
    func startObserve () {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.verifyProximityState)), userInfo: nil, repeats: true)
    }
    
    @objc func verifyProximityState () {
        print(device.proximityState)
        if (device.proximityState == false) {
            self.updateCounterLabel()
        } else {
            // Para de ficar chamando a função
            timer.invalidate()
            // Para de monitorar o proximity state
            device.isProximityMonitoringEnabled = false
        }
    }
    
    func updateCounterLabel () {
        self.timeCounter -= 1
        if self.timeCounter <= 0 {
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
