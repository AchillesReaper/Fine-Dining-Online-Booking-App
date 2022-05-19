//
//  TableAvailabilityViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 13/5/2022.
//

import Foundation
import UIKit

class MenuDateVC: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var daysField: UITextField!
    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius = 10
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        daysField.inputView = pickerView
        daysField.textAlignment = .center
    }
    //Pass Data to Menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMenu" {
            let VC = segue.destination as! MenuVC   
            VC.day = daysField.text!
        }
        
        
    }
}

//Set up PickerView.
extension MenuDateVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        daysField.text = days[row]
        daysField.resignFirstResponder()
    }
}
