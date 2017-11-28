//
//  ViewController.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 24.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let networkClient = NetworkClient.shared
    var fetchResultController: NSFetchedResultsController<City>!
    let dataManager = CoreDataStackManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        attemptFetch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchCity:String = searchBar.text!
        
        networkClient.getCityData(byName: searchCity,
                                  success: { cityData in
                                    appD.saveContext()
                                    self.attemptFetch()
                                    self.tableView.reloadData()
                                    self.searchBar.resignFirstResponder()
            },
                                  failure: { error in
                                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
        })
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        dataManager.deleteAllData(fromEntity: "City")
        appD.saveContext()
        self.attemptFetch()
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: WeatherTableViewCell, indexPath: IndexPath) {
        let city = fetchResultController.object(at: indexPath)
        cell.configureCell(data: city)
    }
    //MARK: - Segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "WeatherDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            let detailsVC = segue.destination as! DetailsVC
            detailsVC.cityData = fetchResultController.object(at: indexPath)
        }
    }
    
    //MARK: - core data request
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        let dateSort = NSSortDescriptor(key: "initDate", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.fetchResultController = controller
        
        do {
            try self.fetchResultController.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
}

