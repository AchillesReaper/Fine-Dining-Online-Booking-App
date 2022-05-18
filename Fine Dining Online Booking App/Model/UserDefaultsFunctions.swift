//
//  UserDefaultsFunctions.swift
//  Fine Dining Online Booking App
//
//  Created by Donald Ho on 18/5/2022.
//

import Foundation

let KEY_Table_STATUS = "tableStatus"
let KEY_BOOKING_RECORD = "bookingRecord"



struct TableInStock: Codable{
    var diningDate: Date
    var tablez = [ "2" : 4, "4" : 2, "6" : 1]
}

struct TableAvailability {
    var diningDate: String
    var availability: String
}

struct BookingDetail: Codable{
    var tableSize: String
    var bookingDate: String
    var customerName: String
    var customerPhone: String
    var customerEmail: String
}




func readTableInStock() -> [TableInStock]{
    let defaults = UserDefaults.standard
    if let savedArrayData = defaults.value(forKey:KEY_Table_STATUS) as? Data {
        if let array = try? PropertyListDecoder().decode(Array<TableInStock>.self, from: savedArrayData) {
            return array
        } else {
            return []
        }
    } else {
        return []
    }
}



func updateTableInStock(updatedRecords: [TableInStock]){
    //update the UserDefaults when a booking is confirmed
    let defaults = UserDefaults.standard
    defaults.set(try? PropertyListEncoder().encode(updatedRecords), forKey: KEY_Table_STATUS)
    
}


func createNewDate(){
    //if userDefaultRecord < 7 <== on date has passed
    //add a new record for TableInStock
    //can used to initialize the userDefault record
    var inventory = readTableInStock()
    //obselete record will be removed
    for item in inventory{
        if item.diningDate < Date(){
            inventory.remove(at: 0)
        }
    }
    while inventory.count < 7 {
        let newRecordDaysFromToday = inventory.count + 1
        let newRecordDate = Calendar.current.date(byAdding: .day, value: newRecordDaysFromToday, to: Date())!
        let newTableInStock = TableInStock(diningDate: newRecordDate)
        inventory.append(newTableInStock)
    }
    updateTableInStock(updatedRecords: inventory)
}


func checkTableAvailability(queryTableSize:String)->[TableAvailability]{
    // this function will check if there is any table available in the future 7 days.
    let inventory = readTableInStock()
    var tableStatus:[TableAvailability] = []
    for index in 0...6{
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "YYYY-MM-dd, E"
        let newDiningDate = dateFomatter.string(from: inventory[index].diningDate)

        var newAvailability: String
        if inventory[index].tablez[queryTableSize]! > 0 {
            newAvailability = "Available"
        }else{
            newAvailability = "Full"
        }
        tableStatus.append(TableAvailability(diningDate: newDiningDate, availability: newAvailability))
    }
    return tableStatus
}


func updateTableInStockATConfirmation(datePicked: String, tableSizePicked: String){
    var inventory = readTableInStock()
    let dateFomatter = DateFormatter()
    dateFomatter.dateFormat = "YYYY-MM-dd, E"
    for index in 0...6{
        let itemDate = dateFomatter.string(from: inventory[index].diningDate)
        if itemDate == datePicked {
            inventory[index].tablez[tableSizePicked]! -= 1
        }
        print(inventory[index])
    }
    updateTableInStock(updatedRecords: inventory)
}




func readBookingRecord() -> [BookingDetail]{
    let defaults = UserDefaults.standard
    if let savedArrayData = defaults.value(forKey: KEY_BOOKING_RECORD) as? Data {
        if let array = try? PropertyListDecoder().decode(Array<BookingDetail>.self, from: savedArrayData) {
            return array
        } else {
            return []
        }
    } else {
        return []
    }
}

//func updateBookingRecord(updatedRecords: [BookingDetail]){
//    //update the UserDefaults when a booking is confirmed
//    let defaults = UserDefaults.standard
//    defaults.set(try? PropertyListEncoder().encode(updatedRecords), forKey: KEY_BOOKING_RECORD)
//}


func confirmBooking(newBooking: [BookingDetail]){
//    var bookings = readBookingRecord()
//    let dateFomatter = DateFormatter()
//    dateFomatter.dateFormat = "YYYY-MM-dd, E"
//    bookings.append(newBooking)
//    updateBookingRecord(updatedRecords: bookings)
    let defaults = UserDefaults.standard
    defaults.set(try? PropertyListEncoder().encode(newBooking), forKey: KEY_BOOKING_RECORD)
}
