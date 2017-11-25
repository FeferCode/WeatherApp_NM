//
//  UIImageView+URL.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithURLString(_ imageCode: String, placeHolder: UIImage?) {
        
        
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: imageCode)) {
            self.image = cachedImage
            return
        }
        
        let imageUrl = createImageUrl(byCode: imageCode)
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageCode))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
    
    private func createImageUrl(byCode code:String) -> String {
        let file = Bundle.main.path(forResource: "ServerCalls", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)
        
        let baseImgUrl = dictionary!["image_url"] as! String
        let urlString = baseImgUrl + code + ".png"
        
        return urlString
    }
}
