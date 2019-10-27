//
//  DestinationViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class DestinationViewController: UIViewController {

    
    @IBOutlet weak var destinationPrompt: UILabel!
    @IBOutlet weak var destinationField: UITextField!
    
    @IBOutlet weak var locationPrompt: UILabel!
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var SegOutlet: UISegmentedControl!
    
    var destination : String?
    var location : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationField.isHidden = true;
        destinationPrompt.isHidden = true;
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func SegValue(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            destinationField.isHidden = true;
            destinationPrompt.isHidden = true;
        } else {
            destinationField.isHidden = false;
            destinationPrompt.isHidden = false;
        }
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        destination = destinationField.text
        location = locationField.text
        
        if location == nil || location! == "" {
            throwAlert()
        }
        
        if SegOutlet.selectedSegmentIndex == 1 && destination! == "" {
            throwAlert()
        }
        
        //Call any functions
        
            self.performSegue(withIdentifier: "destination2time", sender: self)
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "destination2view", sender: self)
    }
    
    func throwAlert() {
        let alertController = UIAlertController(title: "Hello  Coders", message: "You done wrong", preferredStyle: .alert)
        
        //then we create a default action for the alert...
        //It is actually a button and we have given the button text style and handler
        //currently handler is nil as we are not specifying any handler
        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
        
        //now we are adding the default action to our alertcontroller
        alertController.addAction(defaultAction)
        
        //and finally presenting our alert using this method
        present(alertController, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "destination2time" {
            let destinationVC = segue.destination as! TimeViewController
            destinationVC.destination = destination!
            destinationVC.location = location!
        }
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
