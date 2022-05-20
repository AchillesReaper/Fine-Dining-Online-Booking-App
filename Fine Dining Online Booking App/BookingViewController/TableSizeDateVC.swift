//
//  TableSizeDateVC.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 13/5/2022.
//

import Foundation
import UIKit



class TableSizeDateVC: UIViewController {
    @IBOutlet weak var tableSize2: UIButton!
    @IBOutlet weak var tableSize4: UIButton!
    @IBOutlet weak var tableSize6: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func tableForTwo(){
        //parse tableSize = "2" into func checkTableAvailability
        let vc = storyboard?.instantiateViewController(identifier: "TableSizeDateVC") as! TableSizeDateVC
        vc.tableSize = "2"
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navigationItem.setHidesBackButton(false, animated: false)
        
    }
    @IBAction func tableForFour(){
        //parse tableSize = "4" into func checkTableAvailability
        let vc = storyboard?.instantiateViewController(identifier: "TableSizeDateVC") as! TableSizeDateVC
        vc.tableSize = "4"
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    @IBAction func tableForSix(){
        //parse tableSize = "6" into func checkTableAvailability
        let vc = storyboard?.instantiateViewController(identifier: "TableSizeDateVC") as! TableSizeDateVC
        vc.tableSize = "6"
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    @IBOutlet var diningDateField: UITextField!
    @IBOutlet var tableViewHeader: UILabel!
    @IBOutlet var tableAvailibilityView: UITableView!
    
    var tableSize:String = "0"
    var tableAvailability: [TableAvailability] = []
    var pickableDate:[String] = []
    var datePickerView = UIPickerView()
    var updatedTableStatus: [TableAvailability] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableSize2.layer.cornerRadius = 5
        tableSize4.layer.cornerRadius = 5
        tableSize6.layer.cornerRadius = 5
        confirmButton.layer.cornerRadius = 10
        
        createNewDate()
        if tableSize != "0"{
            tableAvailability = checkTableAvailability(queryTableSize: tableSize)
            tableViewHeader.text = "Table for \(tableSize)"
            for item in tableAvailability{
                if item.availability == "Available"{
                    pickableDate.append(item.diningDate)
                }
            }
            diningDateField.inputView = datePickerView
        }
        tableAvailibilityView.delegate = self
        tableAvailibilityView.dataSource = self
        
        datePickerView.delegate = self
        datePickerView.dataSource = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterBookingDetail"{
            let VC = segue.destination as! BookingDetailVC
            if tableSize != "0" && diningDateField.text != nil{
                VC.tableSizePicked = tableSize
                VC.datePicked = diningDateField.text!
            }
        }
    }

}




extension TableSizeDateVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableAvailability.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateAvailability", for: indexPath)
        let record = tableAvailability[indexPath.row]
        cell.textLabel?.text = record.diningDate
        cell.detailTextLabel?.text = record.availability
        return cell
    }
}

extension TableSizeDateVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickableDate.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickableDate[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        diningDateField.text = pickableDate[row]
        diningDateField.resignFirstResponder()
    }
}
