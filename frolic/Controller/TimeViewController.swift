//
//  TimeViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    //previous
    var destination : String = ""
    var location : String = ""
    
    //new
    var startTime : Date = Date()
    var endTime : Date = Date()
    
    var transportationType : String = "car"
    
    //DELETE ME
    let algo = Algo()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startTime(_ sender: UIDatePicker) {
        startTime = sender.date
    }
    
    
    @IBAction func endTime(_ sender: UIDatePicker) {
//        print(sender.date)
//        print(sender.timeZone)
        endTime = sender.date
    }
    
    @IBAction func transportTypeClicked(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            transportationType = "car"
        } else if (sender.selectedSegmentIndex == 1) {
            transportationType = "walk"
        } else if (sender.selectedSegmentIndex == 2) {
            transportationType = "lyft"
        } else {
            transportationType = "scooter"
        }
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        //DELETE ME
        algo.parseDay(startTime, endTime)
        algo.findIntervals()
           
        self.performSegue(withIdentifier: "time2dine", sender: self)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "time2destination", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "time2dine" {
            let destinationVC = segue.destination as! DiningViewController
            destinationVC.destination = destination
            destinationVC.location = location
            destinationVC.endTime = endTime
            destinationVC.startTime = startTime
            destinationVC.transportationType = transportationType
        }
    }
}
