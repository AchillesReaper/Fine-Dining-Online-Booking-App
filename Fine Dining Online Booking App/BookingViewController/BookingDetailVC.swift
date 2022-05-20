//
//  PersonalDetailViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 7/5/2022.
//

import Foundation
import UIKit



class BookingDetailVC: UIViewController {
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet var showTableSizeLabel: UILabel!
    @IBOutlet var customerNameField: UITextField!
    @IBOutlet var customerNameErrorLabel: UILabel!
    @IBOutlet var customerPhoneField: UITextField!
    @IBOutlet var customerPhoneErrorLabel:UILabel!
    @IBOutlet var customerEmailField: UITextField!
    @IBOutlet var customerEmailErrorLabel: UILabel!
    
    var tableSizePicked = ""
    var datePicked = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableSizeLabel.text = "Table for \(tableSizePicked)"
        // Do any additional setup after loading the view.
        confirmButton.layer.cornerRadius = 10
        confirmButton.isEnabled = false
        customerNameErrorLabel.text = "*Require"
        customerNameErrorLabel.isHidden = false
        customerPhoneErrorLabel.text  = "*Required"
        customerPhoneErrorLabel.isHidden = false
        customerEmailErrorLabel.text  = "*Required"
        customerEmailErrorLabel.isHidden = false
        
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
            confirmBooking(newBooking: [newBooking])
            
            let VC = segue.destination as! ConfirmationVC
            VC.segueMsg = "✅ Booking Successful. Thank you!"
            
        }
    }
    
    @IBAction func nameChanged(_ sender: Any){
        if let customerName = customerNameField.text {
            if customerName.count > 1{
            customerNameErrorLabel.isHidden = true
            }
        checkForValidInput()
        }
    }
    
    @IBAction func phoneChanged(_ sender: Any){
        if let customerPhone = customerPhoneField.text {
            if customerPhone.count != 10 {
            customerPhoneErrorLabel.text  = "Invalad Phone Number. Your phone number should have 10 digits"
            customerPhoneErrorLabel.isHidden = false
            }else{
                customerPhoneErrorLabel.isHidden = true
            }
        }
        checkForValidInput()
    }
    
    @IBAction func emailChanged(_ sender: Any){
        if let email = customerEmailField.text {
            let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
            if !predicate.evaluate(with: email){
                customerEmailErrorLabel.text = "Invalid Email Address"
                customerEmailErrorLabel.isHidden = false
            }else{
                customerEmailErrorLabel.isHidden = true
            }
        }
        checkForValidInput()
    }
    
    func checkForValidInput(){
        if (customerNameErrorLabel.isHidden && customerPhoneErrorLabel.isHidden && customerEmailErrorLabel.isHidden){
            confirmButton.isEnabled = true
        }
    }
}
