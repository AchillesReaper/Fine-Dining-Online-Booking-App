//
//  TableSizeViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 13/5/2022.
//

import Foundation
import UIKit

let KEY_Table_STATUS = "tableStatus"
struct TableInStock: Codable{
    var diningDate: Date
    var tablez = [ "2" : 4, "4" : 2, "6" : 1]
}
struct TableAvailability {
    var diningDate: Date
    var availability: String
}


class TableSizeViewController: UIViewController {

    @IBAction func tableForTwo(){
        //parse tableSize = "2" into func checkTableAvailability
        let vc = storyboard?.instantiateViewController(identifier: "TableSizeViewController") as! TableSizeViewController
        vc.tableSize = "2"
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navigationItem.setHidesBackButton(false, animated: false)
        
    }
    @IBAction func tableForFour(){
        //parse tableSize = "4" into func checkTableAvailability
        let vc = storyboard?.instantiateViewController(identifier: "TableSizeViewController") as! TableSizeViewController
        vc.tableSize = "4"
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    @IBAction func tableForSix(){
        //parse tableSize = "6" into func checkTableAvailability
        let vc = storyboard?.instantiateViewController(identifier: "TableSizeViewController") as! TableSizeViewController
        vc.tableSize = "6"
        self.navigationController?.pushViewController(vc, animated: false)
        vc.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    @IBOutlet var diningDateField: UITextField!
    @IBOutlet var tableViewHeader: UILabel!
    @IBOutlet var tableAvailibilityView: UITableView!
    
    var tableSize:String = "0"
    var tableAvailability: [TableAvailability] = []
    var pickableDate:[Date] = []
    var pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewDate()
        if tableSize != "0"{
            checkTableAvailability(queryTableSize: tableSize)
            tableViewHeader.text = "Table for \(tableSize)"
            for item in tableAvailability{
                if item.availability == "Available"{
                    pickableDate.append(item.diningDate)
                }
            }
            diningDateField.inputView = pickerView
        }
        tableAvailibilityView.delegate = self
        tableAvailibilityView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func readUserDefaults(key: String) -> [TableInStock]{
        let defaults = UserDefaults.standard
        if let savedArrayData = defaults.value(forKey:key) as? Data {
            if let array = try? PropertyListDecoder().decode(Array<TableInStock>.self, from: savedArrayData) {
                return array
            } else {
                return []
            }
        } else {
            return []
        }
    }
    
    func updateUserDefaults(updatedRecords: [TableInStock]){
        //update the UserDefaults when a booking is confirmed
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(updatedRecords), forKey: KEY_Table_STATUS)
        
    }
    
    func createNewDate(){
        //if userDefaultRecord < 7 <== on date has passed
        //add a new record for TableInStock
        //can used to initialize the userDefault record
        var booking = readUserDefaults(key: KEY_Table_STATUS)
        //obselete record will be removed
        for item in booking{
            if item.diningDate < Date(){
                booking.remove(at: 0)
            }
        }
        while booking.count < 7 {
            let newRecordDaysFromToday = booking.count + 1
            let newRecordDate = Calendar.current.date(byAdding: .day, value: newRecordDaysFromToday, to: Date())!
            let newTableInStock = TableInStock(diningDate: newRecordDate)
            booking.append(newTableInStock)
        }
        updateUserDefaults(updatedRecords: booking)
    }
    
    func checkTableAvailability(queryTableSize:String){
        let booking = readUserDefaults(key: KEY_Table_STATUS)
//        print(booking)
        for index in 0...6{
            let newDiningDate = booking[index].diningDate
            var newAvailability: String
            if booking[index].tablez[queryTableSize]! > 0 {
                newAvailability = "Available"
            }else{
                newAvailability = "Full"
            }
            tableAvailability.append(TableAvailability(diningDate: newDiningDate, availability: newAvailability))
        }
//        print(tableAvailability)
    }


}




extension TableSizeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableAvailability.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateAvailability", for: indexPath)
        let record = tableAvailability[indexPath.row]
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "YYYY-MM-dd"
        cell.textLabel?.text = dateFomatter.string(from: record.diningDate)
        cell.detailTextLabel?.text = record.availability
        return cell
    }
}

extension TableSizeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickableDate.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "YYYY-MM-dd"
        return dateFomatter.string(from: pickableDate[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "YYYY-MM-dd"
        diningDateField.text = dateFomatter.string(from: pickableDate[row])
        diningDateField.resignFirstResponder()
    }
}
