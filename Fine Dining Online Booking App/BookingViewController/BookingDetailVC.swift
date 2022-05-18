//
//  PersonalDetailViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 7/5/2022.
//

import Foundation
import UIKit



class BookingDetailVC: UIViewController {

    @IBOutlet var customerNameField: UITextField!
    @IBOutlet var customerPhoneField: UITextField!
    @IBOutlet var customerEmailField: UITextField!
    
    var tableSizePicked = ""
    var datePicked = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmBooking" {
            let newBooking = BookingDetail(
                tableSize: tableSizePicked,
                bookingDate: datePicked,
                customerName: customerNameField.text!,
                customerPhone: customerPhoneField.text!,
                customerEmail: customerEmailField.text!
            )
            updateTableInStockATConfirmation(datePicked: datePicked, tableSizePicked: tableSizePicked)
            confirmBooking(newBooking: newBooking)
            
            let VC = segue.destination as! ConfirmationVC
            VC.yourBooking = newBooking
            print("newBooking: \(newBooking)")
        }
    }
    
    

    
    
    
    
    
    
}
