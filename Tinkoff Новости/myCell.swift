//
//  myCell.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 20/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import UIKit

class MyCell: UITableViewCell {
    var title: String?
    
    @IBOutlet weak var titleLabel: UILabel!

    func configure(titl: String) {
        titleLabel.text = titl
    }
}
