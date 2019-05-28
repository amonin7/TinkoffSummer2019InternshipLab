//
//  urlSession.swift
//  Tinkoff Новости
//
//  Created by Andrey Minin on 20/05/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import UIKit

struct News: Codable {
    var id : String
    var title: String
    var slug: String
}

extension ViewController {
    func getNews() {
        let urlString = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles"
        var resultTitles = [News]()
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
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
                        var currentNew = News(id: "", title: "", slug: "")
                        currentNew.title = new["title"] as! String
                        currentNew.id = new["id"] as! String
                        currentNew.slug = new["slug"] as! String
                        resultTitles.append(currentNew)
                    }
                    self.newss = resultTitles
                    DispatchQueue.main.async {
                        self.mainTableView.reloadData()
                    }
                } catch {
                    // Если вдруг не вышло получить JSON из полученной даты
                    print("Error trying to convert data to JSON")
                    return
                }
            }
        }
        task.resume()
    }
}
    
extension OneNewsVC {
    func getAloneNewsInfo(slug: String) {
        let urlString = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle?urlSlug=\(slug)"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
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
                    guard let responce = json["response"] as? [String: Any] else {
                        return
                    }
                
                    //print(responce["text"])
                    let htmlText = responce["text"] as! String
                    self.newsText = String(htmlEncoding: htmlText)!
                    DispatchQueue.main.async {
                        self.mainTextView.text = self.newsText
                    }
                } catch {
                    // Если вдруг не вышло получить JSON из полученной даты
                    print("Error trying to convert data to JSON")
                    return
                }
            }
        }
        task.resume()
    }
}

extension String {
    
    init?(htmlEncoding: String) {
        guard let data = htmlEncoding.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        
        self.init(attributedString.string)
    }
}

