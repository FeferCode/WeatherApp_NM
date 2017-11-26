//
//  DetailsVC.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import UIKit
import MessageUI

class DetailsVC: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var presureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var cityData:City?
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.scrollView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
            self.scrollView.updateConstraints()
        } else if UIDevice.current.orientation.isPortrait {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.scrollView.updateConstraints()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDetailsView(withCityData: self.cityData!)
    }
    
    func configureDetailsView(withCityData data: City){
        self.title = data.name
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }

        if let url = data.icon {
            self.dImage.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
        }
        
        
        
        self.descriptionLabel.text = data.weather_description!
        self.dateLabel.text = formatDate(date: data.date!)
        self.tempLabel.text = String(describing: data.temp) + " °C"
        self.tempMaxLabel.text = String(describing: data.temp_max) + " °C"
        self.tempMinLabel.text = String(describing: data.temp_min) + " °C"
        self.presureLabel.text = String(describing: data.pressure) + " hPa"
        self.humidityLabel.text = String(describing: data.humidity) + "%"
    }
    
    @IBAction func sendWeatherButton(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "\(self.cityData!.name ?? "nil") \(self.cityData!.temp)°C, \(self.cityData?.weather_description ?? "nil")"
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResult.cancelled.rawValue:
            self.dismiss(animated: true, completion: nil)
            let message = NSLocalizedString("Message was canceled", comment: "DetailVC")
            let status = NSLocalizedString("Information", comment: "DetailVC")
            messageAlert(withText: message, status: status)
            
        case MessageComposeResult.failed.rawValue:
            self.dismiss(animated: true, completion: nil)
            let message = NSLocalizedString("Failed to send message", comment: "DetailVC")
            let status = NSLocalizedString("Error", comment: "DetailVC")

            messageAlert(withText: message, status: status)
        case MessageComposeResult.sent.rawValue:
            self.dismiss(animated: true, completion: nil)
            let message = NSLocalizedString("Message was send", comment: "DetailVC")
            let status = NSLocalizedString("Success", comment: "DetailVC")
            messageAlert(withText: message, status: status)
        default:
            break;
        }
    }
    
    func messageAlert(withText text:String, status:String){
        let alert = UIAlertController(title: status, message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func formatDate(date:NSDate) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm dd-MM-yyyy"
        
        let newDate: NSDate? = date
        return dateFormatterPrint.string(from: newDate! as Date)
    }
}





