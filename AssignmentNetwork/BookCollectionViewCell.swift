//
//  BookCollectionViewCell.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = FontStyle.primary
        authorsLabel.textColor = .gray
        authorsLabel.font = FontStyle.sub
        priceLabel.font = FontStyle.primary
    }
    
    func configureCell(row: Document) {
        let url = URL(string: row.thumbnail)
        thumbnailImageView.kf.setImage(with: url)
        titleLabel.text = row.title
        authorsLabel.text = row.authorsText
        priceLabel.text = row.priceText
        
    }

}
