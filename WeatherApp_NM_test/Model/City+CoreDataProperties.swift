//
//  City+CoreDataProperties.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var humidity: Int16
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var initDate: NSDate?
    @NSManaged public var main: String?
    @NSManaged public var name: String?
    @NSManaged public var pressure: Int16
    @NSManaged public var temp: Float
    @NSManaged public var temp_max: Float
    @NSManaged public var temp_min: Float
    @NSManaged public var weather_description: String?

}
