//
//  OneNewsVC.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 22/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class OneNewsVC: UIViewController {

    var newsSlug: String = ""
    var newsText = ""
    
    @IBOutlet weak var mainTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAloneNewsInfo(slug: newsSlug)
        
        navigationItem.title = "Tinkoff Новость"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        mainTextView.text = newsText
    }

}
