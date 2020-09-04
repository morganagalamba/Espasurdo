//
//  DatePickerViewController.swift
//  Espasurdo
//
//  Created by José Henrique Fernandes Silva on 31/08/20.
//  Copyright © 2020 Morgana Beatriz. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Data máxima: dia atual
        let maxDate = Date()
        // Data mínima: 28/06/1995
        let minDate = Date(timeIntervalSince1970: (31536000*25)+(172*86400))
        
        self.datePicker.maximumDate = maxDate
        self.datePicker.minimumDate = minDate
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self.datePicker.date)
        
        UserDefaults.standard.set(dateString, forKey: "date")
        
        if segue.identifier == "showApiDate", case let nextVC = segue.destination as? ApiDataViewController {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            // Passar data formatada para view ApiData
            nextVC?.dateString = formatter.string(from: self.datePicker.date)
        }
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
