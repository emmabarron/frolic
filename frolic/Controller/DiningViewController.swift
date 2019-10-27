//
//  DiningViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class DiningViewController: UIViewController {
    
    var destination : String = ""
    var location : String = ""
    
    var startTime : Date = Date()
    var endTime : Date = Date()
    
    var transportationType : String = ""
    
    //new
    var meals : Int = 0
    var snacks : Int = 0
    
    var expenses : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mealSeg(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            meals = 1
        } else if (sender.selectedSegmentIndex == 1) {
            meals = 2
        } else if (sender.selectedSegmentIndex == 2) {
            meals = 3
        }
    }
    
    @IBAction func snackSeg(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            snacks = 1
        } else if (sender.selectedSegmentIndex == 1) {
            snacks = 2
        } else if (sender.selectedSegmentIndex == 2) {
            snacks = 3
        }
    }
    
    @IBAction func expenseSeg(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            expenses = 1
        } else if (sender.selectedSegmentIndex == 1) {
            expenses = 2
        } else if (sender.selectedSegmentIndex == 2) {
            expenses = 3
        } else {
            expenses = 4
        }
    }

    @IBAction func nextClicked(_ sender: UIButton) {
        print(destination)
        print(location)
        print(startTime)
        print(endTime)
        print(transportationType)
        print(meals)
        print(snacks)
        print(expenses)
        
        self.performSegue(withIdentifier: "dine2buffer", sender: self)
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "dine2time", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dine2buffer" {
            let destinationVC = segue.destination as! BufferViewController
            destinationVC.destination = destination
            destinationVC.location = location
            destinationVC.endTime = endTime
            destinationVC.startTime = startTime
            destinationVC.transportationType = transportationType
            destinationVC.meals = meals
            destinationVC.snacks = snacks
            destinationVC.expenses = expenses
        }
    }
}
