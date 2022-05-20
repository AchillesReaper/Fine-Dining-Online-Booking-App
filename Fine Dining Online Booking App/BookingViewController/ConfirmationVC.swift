//
//  ConfirmedViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 7/5/2022.
//

import Foundation
import UIKit

class ConfirmationVC: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var msgLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBAction func showMenu(){
        let vc = storyboard?.instantiateViewController(identifier: "MenuVC") as! MenuVC
        vc.day = weekday
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    @IBAction func cancelBooking(){
        var inventory = readTableInStock()
        let myBooking = readBookingRecord()
        if myBooking.count > 0{
            let dateFomatter = DateFormatter()
            dateFomatter.dateFormat = "YYYY-MM-dd, E"
            for index in 0...6{
                let itemDate = dateFomatter.string(from: inventory[index].diningDate)
                if itemDate == myBooking[0].bookingDate {
                    inventory[index].tablez[myBooking[0].tableSize]! += 1
                }
            }
            updateTableInStock(updatedRecords: inventory)
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: KEY_BOOKING_RECORD)
        }
        let vc = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    @IBAction func backToHome(){
        let vc = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    var yourBooking: BookingDetail?
    var weekday = ""
    var segueMsg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        
        msgLabel.text = segueMsg
        if (readBookingRecord().count > 0 ){
            yourBooking = readBookingRecord()[0]
//            in reality or multi-bookings are stored, the above line should be rewritten as below,
//            yourBooking = readBookingRecord().last
            nameLabel.text = yourBooking!.customerName
            dateLabel.text = yourBooking!.bookingDate
            sizeLabel.text = yourBooking!.tableSize
            
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


}
