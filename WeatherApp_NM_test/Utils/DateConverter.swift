//
//  DateConverter.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 24.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import Foundation

public final class DateConverte {
    public class func intToDate(forNumber number:Int) -> Date {
        let time = Double(number)
        return Date(timeIntervalSince1970: time)
    }
    
    public class func dateToInt(forDate date:Date) -> Int {
        let time = date.timeIntervalSince1970
        return Int(time)
    }
    
    
}
