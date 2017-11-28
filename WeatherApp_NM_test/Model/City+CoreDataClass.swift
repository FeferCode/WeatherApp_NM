//
//  City+CoreDataClass.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//
//

import Foundation
import CoreData


public class City: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.initDate = NSDate()
    }
    
    internal struct MainKeys {
        static let main = "main"
        static let name = "name"
        static let weather = "weather"
        static let date = "dt"
    }
    
    internal struct WeatherKey {
        static let main = "main"
        static let icon = "icon"
        static let description = "description"
        static let id = "id"
    }
    
    internal struct TempKeys {
        static let temp = "temp"
        static let pressure = "pressure"
        static let humidity = "humidity"
        static let temp_min = "temp_min"
        static let temp_max = "temp_max"
    }
    
    func setData(json:[String:Any]){
        guard let name = json[MainKeys.name] as? String,
        let date = json[MainKeys.date] as? Int
            else { return }
        self.name = name
        self.date = DateConverte.intToDate(forNumber: date) as NSDate
        
        if let weatherDictionary = json[MainKeys.weather] as? [[String:Any]] {
            let weather = weatherDictionary.first as [String:Any]!
            guard let main = weather![WeatherKey.main] as? String,
                let icon = weather![WeatherKey.icon] as? String,
                let description = weather![WeatherKey.description] as? String,
                let id = weather![WeatherKey.id] as? Int64
                else  { return }
            self.main = main
            self.icon = icon
            self.weather_description = description
            self.id = id
        } else { return }
        
        if let weatherDictionary = json[MainKeys.main] as? [String:Any] {
            guard let temp = weatherDictionary[TempKeys.temp] as? Float,
                let pressure = weatherDictionary[TempKeys.pressure] as? Int16,
                let humidity = weatherDictionary[TempKeys.humidity] as? Int16,
                let temp_min = weatherDictionary[TempKeys.temp_min] as? Float,
                let temp_max = weatherDictionary[TempKeys.temp_max] as? Float
                else  { return }
            self.temp = temp
            self.pressure = pressure
            self.humidity = humidity
            self.temp_min = temp_min
            self.temp_max = temp_max
        } else { return }
    }
    
}
