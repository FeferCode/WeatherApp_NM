//
//  Int+HTTPStatusCode.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 24.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//


extension Int {
  public var isSuccessHTTPCode: Bool {
    return 200 <= self && self < 300
  }
}
