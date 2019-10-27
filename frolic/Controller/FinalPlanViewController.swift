//
//  FinalPlanViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class FinalPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events : Array<Place> = Array<Place>()
    var event_2 : Array<Place> = Array<Place>()
    var counter : Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("begin loading")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AdventureTableViewCell", bundle: nil), forCellReuseIdentifier: "adventureCell")
        print("stop loading")
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adventureCell", for: indexPath) as! AdventureTableViewCell
        cell.theNumber.text = String(counter)
        cell.theTitle.text = events[indexPath.row].name
        cell.theParagraph.text = String(events[indexPath.row].price_level)
        counter += counter
        return cell
//        let array1 = ["title1", "title2", "title3", "title4", "title1", "title2", "title3", "title4"]
//        let array2 = ["par.ljlkse jfSIofseo ragraph 1 yayayayyay", "paragraph 2 yayayayyay", "paragraph 3 yayayayyay", "paragraph 4 yayayayyay", "par.ljlkse jfSIofseo ragraph 1 yayayayyay", "paragraph 2 yayayayyay", "paragraph 3 yayayayyay", "paragraph 4 yayayayyay"]
        //let array3 = ["1", "2", "3", "4", "5", "6", "7", "8"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
    }
}
