//
//  ViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 7/5/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var reserveTableButton: UIButton!
    @IBOutlet weak var appointmentHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuButton.layer.cornerRadius = 10
        reserveTableButton.layer.cornerRadius = 10
        appointmentHistoryButton.layer.cornerRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBooking" {
            let VC = segue.destination as! ConfirmationVC
            VC.segueMsg = "Your Booking"
        }
    }


}

