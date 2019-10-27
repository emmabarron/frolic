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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToFinal(_ sender: UIButton) {
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

}
