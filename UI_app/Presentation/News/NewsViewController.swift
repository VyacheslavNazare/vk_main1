//
//  NewsViewController.swift
//  UI_app
//
//  Created by Вячеслав on 04.09.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let newsAPI = NewsAPI()
    var news: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.global(qos: .userInteractive).async {
            self.newsAPI.getNews (completion: { [weak self]  news in
            guard let self = self else { return }
            print("NNNNNEEEEEWWWWWWSSSSS")
            self.news = news
            self.tableView.reloadData()
        })
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.identifier, for: indexPath) as! NewsViewCell
        let new = news[indexPath.item]
        cell.configure(news: new)
        return cell
    }
}

