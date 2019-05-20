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
    var title: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    
//    func configure(titl: String) {
//        title = titl
//        //titleLabel.text = title!
//        if let label = titleLabel {
//            label.text = "sukini deti"
//        }
//        print(title)
//        //titleLabel.text = title
//    }
}
