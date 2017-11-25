//
//  CoreDataStackManager.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStackManager{
    
    static let shared = CoreDataStackManager()
    private init(){}

    func deleteAllData(fromEntity entity: String){
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            
        }
    }
    
}
