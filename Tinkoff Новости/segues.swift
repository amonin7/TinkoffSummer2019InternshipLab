//
//  segues.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 22/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedNews" {
            let destVC = segue.destination as! OneNewsVC
        }
    }
}

