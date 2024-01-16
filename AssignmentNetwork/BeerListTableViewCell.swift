//
//  BeerListTableViewCell.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/16/24.
//

import UIKit

class BeerListTableViewCell: UITableViewCell {
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerABVLabel: UILabel!
    @IBOutlet var beerDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        beerNameLabel.font = FontStyle.name
        beerABVLabel.font = FontStyle.ABV
        beerDescriptionLabel.font = FontStyle.descirption
        beerDescriptionLabel.numberOfLines = 0
    }
    
    func configureCell(row: BeerList) {
        let imageurl = URL(string: row.image_url)
        beerImageView.kf.setImage(with: imageurl)
        beerNameLabel.text = row.name
        beerABVLabel.text = row.abvString
        beerDescriptionLabel.text = row.description
    }
    
}
