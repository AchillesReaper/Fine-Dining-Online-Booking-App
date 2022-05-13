//
//  GetData.swift
//  Fine Dining Online Booking App
//
//  Created by Lok on 12/5/2022.
//

import Foundation

struct Dish : Codable {
    let uuid: Int
    let appetizer: String
    let sashimiPlate: String
    let main: String
    let dessert: String
    let price: Int
}

func parseJson() -> [Dish]?{
       if let url = Bundle.main.url(forResource: "meal", withExtension: "json") {
           do {
               let data = try Data(contentsOf: url)
               let response = try JSONDecoder().decode([Dish].self, from: data)
               return response
           } catch {
               print(error)
           }
       }
    
    return nil
}
