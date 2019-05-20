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

    @IBOutlet weak var cntLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        cntLabel.text = "0"
    }

    func configure() {
        cntLabel.backgroundColor = .green
        titleLabel.textColor = .yellow
        cntLabel.clipsToBounds = true
        cntLabel.layer.borderWidth = 1.5
        cntLabel.layer.cornerRadius = 8

    }
    
    
}
