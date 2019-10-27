//
//  ViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let handler = eventbriteHandler()
    let algo = Algo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fake_button(_ sender: Any) {
        let handler = lyftHandler()
        return handler.getCosts(pickup: "klaus advanced computing building", dropoff: "coca cola building atlanta georgia") {
            cost,duration in
            // do stuff w/ cost & duration here
            print(cost)
        }
    }
    
    @IBAction func adventureClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "view2destination", sender: self)
    }
    @IBAction func popularClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "view2code", sender: self)
    }
}

