//
//  FinalPlanViewController.swift
//  frolic
//
//  Created by Huda T on 10/26/19.
//  Copyright © 2019 adventurers. All rights reserved.
//

import UIKit

class FinalPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "AdventureTableViewCell", bundle: nil), forCellReuseIdentifier: "adventureCell")
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "adventureCell", for: indexPath) as! AdventureTableViewCell
        
        let array1 = ["title1", "title2", "title3", "title4", "title1", "title2", "title3", "title4"]
        let array2 = ["par.ljlkse jfSIofseo ragraph 1 yayayayyay", "paragraph 2 yayayayyay", "paragraph 3 yayayayyay", "paragraph 4 yayayayyay", "par.ljlkse jfSIofseo ragraph 1 yayayayyay", "paragraph 2 yayayayyay", "paragraph 3 yayayayyay", "paragraph 4 yayayayyay"]
        let array3 = ["1", "2", "3", "4", "1", "2", "3", "40"]
        
        cell.theNumber.text = array3[indexPath.row]
        cell.theTitle.text = array1[indexPath.row]
        cell.theParagraph.text = array2[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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
