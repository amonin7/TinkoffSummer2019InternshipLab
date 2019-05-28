//
//  ViewController.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 19/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var newss = [News]()
    
    var newsFromDB = [DataEntity]()
    
    var cds = CoreDataStack()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        getNews()
        self.mainTableView.dataSource = self
        self.mainTableView.delegate = self
    }
    
    func setupTV() {
        navigationItem.title = "Tinkoff Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .yellow
        mainTableView.backgroundColor = .black
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        
        
        
        cell.titleLabel.text = newss[indexPath.row].title
        cell.cntLabel.text = "0"
        
        cell.configure()
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cnt = findIDinDB(news: newsFromDB, id: newss[indexPath.row].id)
        cnt += 1
        let currentNews = DataEntity(context: context)
        currentNews.clicksAmount = Int32(cnt)
        
        cds.performSave(with: context)
        let model = cds.managedObjectModel
        let fetchRequest = DataEntity.fetchRequestDataEntity(model: model)
        do {
            newsFromDB = try cds.mainContext.fetch(fetchRequest!)
        } catch {
            print("Error -> \(error)")
        }
        mainTableView.reloadData()
        
        performSegue(withIdentifier: "selectedNews", sender: newss[indexPath.row].slug)
    }
}

