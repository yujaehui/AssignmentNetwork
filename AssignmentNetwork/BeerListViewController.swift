//
//  BeerListViewController.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/16/24.
//

import UIKit
import Alamofire
import Kingfisher

class BeerListViewController: UIViewController {
    
    @IBOutlet var beerTableView: UITableView!
    
    var list: [BeerList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        callRequest()
    }
}

extension BeerListViewController {
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers"
        AF
            .request(url)
            .responseDecodable(of: [BeerList].self) { response in
                switch response.result {
                case .success(let success):
                    self.list = success
                    self.beerTableView.reloadData()
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}

extension BeerListViewController {
    func configureTableView() {
        beerTableView.dataSource = self
        beerTableView.delegate = self
        
        let xib = UINib(nibName: BeerListTableViewCell.identifier, bundle: nil)
        beerTableView.register(xib, forCellReuseIdentifier: BeerListTableViewCell.identifier)
        
        beerTableView.rowHeight = UITableView.automaticDimension
    }
}

extension BeerListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.identifier, for: indexPath) as! BeerListTableViewCell
        let row = list[indexPath.row]
        cell.configureCell(row: row)
        return cell
    }
}
