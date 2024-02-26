//
//  CatAPIEndpoints.swift
//  AllCatPics
//
//  Created by John Trujillo on 26/2/24.
//

import Foundation

struct CatAPIEndpoints {
    static let base = "https://cataas.com"
    static func catList(limit: Int, skip: Int) -> String {
        "\(base)/api/cats?limit=\(limit)&skip=\(skip)"
    }
    static func catDetail(id: String) -> String {
        "\(base)/cat/\(id)?json=true"
    }
    static func catImageURL(id: String) -> String {
        "\(base)/cat/\(id)"
    }
    static func catSaysImageURL(id: String, text: String) -> String {
        "\(base)/cat/\(id)/says/\(text)?fontSize=50&fontColor=white"
    }
}
