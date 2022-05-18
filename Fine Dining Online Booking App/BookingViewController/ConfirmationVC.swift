//
//  ConfirmedViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 7/5/2022.
//

import Foundation
import UIKit

class ConfirmationVC: UIViewController {

    @IBOutlet var nameLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var sizeLable: UILabel!
    @IBAction func showMenu(){
        let vc = storyboard?.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
        vc.day = weekday
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    var yourBooking: BookingDetail?
    var weekday = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Your Booking")
        print(yourBooking!)
        nameLable.text = yourBooking!.customerName
        dateLable.text = yourBooking!.bookingDate
        sizeLable.text = yourBooking!.tableSize
        
        //converting a String to a Date object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd', 'EEE"
        let date = dateFormatter.date(from: yourBooking!.bookingDate)
        print(date!)
        //converting a Date object to a weekday string
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date!)
        print("Weekday: \(weekday)")
        
    }


}
