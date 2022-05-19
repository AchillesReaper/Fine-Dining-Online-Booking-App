//
//  MenuViewController.swift
//  Fine Dining Online Booking App
//
//  Created by Guo Chen on 7/5/2022.
//

import Foundation
import UIKit

class MenuVC: UIViewController{
    @IBOutlet weak var appetizerTab: UILabel!
    @IBOutlet weak var sashimiTab: UILabel!
    @IBOutlet weak var mainTab: UILabel!
    @IBOutlet weak var dessertTab: UILabel!
    @IBOutlet weak var dayTab: UILabel!
    @IBOutlet weak var priceTab: UILabel!
    var day:String = "Monday"

    override func viewDidLoad() {
        //Get JSON DATA From GetData
        let menu = parseJson()
        //Show menu based on current day of the week
        //We can simply add new meal based on date by adding new case
        
        var cDay:Int;
        switch day {
        case "Monday", "Wednesday", "Friday","Sunday":
            cDay = 0
        case "Tuesday", "Thursday", "Saturday":
            cDay = 1
        default:
            print("Error")
            cDay = 0
        }
        //Change each Label.text to correct Item
        dayTab.text = day
        appetizerTab.text = menu?[cDay].appetizer
        sashimiTab.text = menu?[cDay].sashimiPlate
        mainTab.text = menu?[cDay].main
        dessertTab.text = menu?[cDay].dessert
        priceTab.text = String((menu?[cDay].price)!)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
 
    }
    
    
    
}

