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
        
        let datadata = DataEntity.insertData(in: cds.mainContext, newsid: newss[indexPath.row].id, newsTitle: newss[indexPath.row].title)
        do {
            try cds.mainContext.save()
        } catch {
            print(error)
        }
        //print(datadata ?? "lost")

        
        //let cnt = findIDinDB(news: newsFromDB, id: newss[indexPath.row].id)
        
        cell.titleLabel.text = newss[indexPath.row].title
        cell.cntLabel.text = String(findIDinDB(id: newss[indexPath.row].id).clicksAmount)
        
        cell.configure()
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cnt = findIDinDB(id: newss[indexPath.row].id)
        cnt.clicksAmount += 1
        print(cnt)
        let currentNews = DataEntity(context: context)
        currentNews.clicksAmount = Int32(cnt.clicksAmount)
        
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

