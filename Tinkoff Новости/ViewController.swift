//
//  ViewController.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 19/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainTableView: UITableView!
    // я пишу пишу пишу! не успеваю! извините!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        mainTableView.reloadData()
        sess()
        // Do any additional setup after loading the view.
    }
    
    func setupTV() {
        navigationItem.title = "Tinkoff Chat"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Mycell
        cell.configire(indexPath: indexPath, users : )
        return cell
        
    }*/
}



