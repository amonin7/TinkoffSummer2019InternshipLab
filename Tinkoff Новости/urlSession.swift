//
//  urlSession.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 20/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import UIKit

func sess() -> [String] {
    let urlString = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles"
    var resultTitles: [String] = []
    guard let url = URL(string: urlString) else { return [String]() }
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?,
        error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // Если есть данные - работаем с ними
        if let data = data {
            // Делаем JSON из полученной даты
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    return
                }
                guard let responce = json["response"] as? [String: Any],
                    let news = responce["news"] as? [[String: Any]] else {
                        return
                }
                for new in news {
                    let title = new["title"]
                    resultTitles.append(title as! String)
                }
            } catch {
                // Если вдруг не вышло получить JSON из полученной даты
                print("Error trying to convert data to JSON")
                return
            }
        }
    }
    task.resume()
    return resultTitles
}
