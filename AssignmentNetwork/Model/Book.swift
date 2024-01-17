//
//  Book.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    // 외부에서 설정한 키를 다른 키로 매칭하는 과정
    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
    
    var authorsText: String {
        if authors.count == 1 {
            "\(authors[0])"
        } else if authors.count > 1 {
            "\(authors[0]) 외 \(authors.count - 1)인"
        } else {
            "작가 미정"
        }
        
        
    }
    var priceText: String {
        "\(price)원"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
