//
//  BufferViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class BufferViewController: UIViewController {
    
    var destination : String = ""
    var location : String = ""
    
    var startTime : Date = Date()
    var endTime : Date = Date()
    
    var transportationType : String = ""
    
    //new
    var meals : Int = 0
    var snacks : Int = 0
    
    var expenses : Int = 0
    
    var events : Array<Place> = Array<Place>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var algo = Algo()
    
    @IBAction func goToFinal(_ sender: UIButton) {
        algo.parseDay(startTime, endTime)
        var intervals : [(String, (Int, Int))] = algo.findIntervals()
        let handler = googleHandler()
        handler.geocode(location: location) {
            loc in
            var event_type :Type
            
            for interval in intervals {
                print("interval")
                if (interval.0 == "NF") {
                    event_type = Type.ACTIVITY
                } else if (interval.0 == "F") {
                    event_type = Type.MEAL
                } else {
                    event_type = Type.SNACK
                }
                handler.findPlace(event_type, latitude: loc!.0, longitude: loc!.1) {
                    place in
                    print("addingp place")
                    self.events.append(place!)
                }
            }
        }
        self.performSegue(withIdentifier: "buffer2final", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buffer2final" {
            let destinationVC = segue.destination as! FinalPlanViewController
            destinationVC.events = events
            print(events)
//            destinationVC.location = location
//            destinationVC.endTime = endTime
//            destinationVC.startTime = startTime
//            destinationVC.transportationType = transportationType
//            destinationVC.meals = meals
//            destinationVC.snacks = snacks
//            destinationVC.expenses = expenses
        }
    }

}
