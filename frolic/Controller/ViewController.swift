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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fake_button(_ sender: Any) {
        //handler.theFunc()
    }
    
    @IBAction func adventureClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "view2destination", sender: self)
    }
    @IBAction func popularClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "view2code", sender: self)
    }
}

