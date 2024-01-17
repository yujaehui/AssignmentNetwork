//
//  BookViewController.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import UIKit
import Alamofire
import Kingfisher

class BookViewController: UIViewController {
    
    var bookList: [Document] = []
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    func callRequest(text: String) {
        // 만약 한글 검색이 안된다면 인코딩 처리
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)"
        let headers: HTTPHeaders = ["Authorization" : APIKey.Authorization]
        
        AF
            .request(url,
                     method: .get,
                     headers: headers)
            .responseDecodable(of: Book.self) { response in
                switch response.result {
                case .success(let success):
                    print(success.documents)
                    self.bookList = success.documents
                    self.bookCollectionView.reloadData()
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}

extension BookViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        let row = bookList[indexPath.row]
        cell.configureCell(row: row)
        return cell
    }
}

extension BookViewController {
    func configureCollectionView() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        let xib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        bookCollectionView.register(xib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 2 + 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        bookCollectionView.collectionViewLayout = layout
    }
}

extension BookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("error")
            return
        }
        callRequest(text: searchText)
    }
}
