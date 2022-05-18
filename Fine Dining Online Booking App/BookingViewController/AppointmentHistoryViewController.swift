//
//  AppointmentHistoryViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 13/5/2022.
//

import Foundation
import UIKit

class AppointmentHistoryViewController: UIViewController {

    @IBOutlet var myBookingRecordsTV: UITableView!
    var myBookings = [BookingDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myBookings = readBookingRecord()
        myBookingRecordsTV.delegate = self
        myBookingRecordsTV.dataSource = self
    }


}

extension AppointmentHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookingRecord", for: indexPath)
        let record = myBookings[indexPath.row]
        cell.textLabel?.text = record.bookingDate
        cell.detailTextLabel?.text = "table for \(record.tableSize)"
        return cell
    }
}
