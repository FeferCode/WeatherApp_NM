//
//  NetworkClient.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 24.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import Foundation


public final class NetworkClient {
    internal let session = URLSession.shared
    
    public static let shared: NetworkClient = { return NetworkClient() }()

    private init(){}
    
    //MARK: - GetCityData
    public func getCityData(byName name:String,
                            success _success: @escaping (City) -> Void,
                            failure _failure: @escaping (NetworkError) -> Void) {
        
        let success: (City) -> Void = { city in
            DispatchQueue.main.async { _success(city) }
        }
        let failure: (NetworkError) -> Void = { error in
            DispatchQueue.main.async { _failure(error) }
        }
        
        let url = createUrl(byCityName: name)
        let task = session.dataTask(with: url, completionHandler : { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode.isSuccessHTTPCode,
            let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
                let json = jsonObject as? [String:Any] else {
                    if let error = error {
                        failure(NetworkError(error: error))
                    } else {
                        failure(NetworkError(response: response))
                    }
                return
            }
            
            let cityData = City(context: context)
            cityData.setData(json: json)
            success(cityData)

        })
        task.resume()
    }
}
