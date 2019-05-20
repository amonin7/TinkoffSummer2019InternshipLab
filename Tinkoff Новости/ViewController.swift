//
//  ViewController.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 19/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var newss = [String]()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        sess()
        self.mainTableView.dataSource = self
        //self.mainTableView.delegate = self
    }
    
    func setupTV() {
        navigationItem.title = "Tinkoff Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        
        cell.titleLabel.text = newss[indexPath.row]
        cell.cntLabel.text = "0"
        cell.cntLabel.backgroundColor = .red
        cell.titleLabel.backgroundColor = .green
        cell.titleLabel.layer.cornerRadius = 2
        cell.cntLabel.layer.cornerRadius = 2
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
