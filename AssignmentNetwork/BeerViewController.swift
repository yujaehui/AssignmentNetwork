//
//  BeerViewController.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/16/24.
//

import UIKit
import Alamofire
import Kingfisher

class BeerViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var BeerImageView: UIImageView!
    @IBOutlet var BeerNameLabel: UILabel!
    @IBOutlet var BeerDescriptionLabel: UILabel!
    @IBOutlet var randomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = "오늘은 이 맥주를 추천합니다!"
        mainLabel.textAlignment = .center
        mainLabel.font = FontStyle.main
        
        BeerNameLabel.textAlignment = .center
        BeerNameLabel.font = FontStyle.name
        
        BeerDescriptionLabel.textAlignment = .center
        BeerDescriptionLabel.font = FontStyle.descirption
        BeerDescriptionLabel.numberOfLines = 0
        
        randomButton.setImage(UIImage(systemName: "mug.fill"), for: .normal)
        randomButton.setTitle(" 다른 맥주 추천받기", for: .normal)
        randomButton.tintColor = .orange
        randomButton.layer.cornerRadius = 10
        randomButton.backgroundColor = .orange.withAlphaComponent(0.1)
        callRequest()
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF
            .request(url)
            .responseDecodable(of: [Beer].self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    DispatchQueue.main.async { [weak self] in
                        self?.BeerNameLabel.text = success[0].name
                        self?.BeerDescriptionLabel.text = success[0].description
                        let imageurl = URL(string: success[0].image_url)
                        self?.BeerImageView.kf.setImage(with: imageurl)
                    }

                case .failure(let failure):
                    print(failure)
                }
            }
    }
}
