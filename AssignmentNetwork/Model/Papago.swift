//
//  Papago.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import Foundation

struct Papago: Codable {
    let message: Message
}

struct Message: Codable {
    let result: Result
}

struct Result: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}
