//
//  NetworkClient+UrlCreator.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 24.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import Foundation

extension NetworkClient {
    
    public func createUrl(byCityName: String) -> URL{
        let file = Bundle.main.path(forResource: "ServerCalls", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)
        
        let baseURLString = dictionary!["api_base_call"] as! String
        let searchByCity = dictionary!["search_city_by_name"] as! String
        let units = dictionary!["metric_units"] as! String
        let apiKey = dictionary!["api_key"] as! String
        
        let urlString = baseURLString + searchByCity + byCityName + units + apiKey
        return URL(string: urlString)!
    }
    
    
}

