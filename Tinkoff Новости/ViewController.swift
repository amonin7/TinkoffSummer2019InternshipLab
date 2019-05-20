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
    // я пишу пишу пишу! не успеваю! извините!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        sess()
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self

        // Do any additional setup after loading the view.
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
        
        return cell
    }
}
