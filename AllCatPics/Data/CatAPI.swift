//
//  CatAPI.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatAPIProtocol {
    func fetchCatList() async throws -> [Cat]
    func fetchCatDetail(id: String) async throws -> Cat
}

class CatAPI: CatAPIProtocol {
    func fetchCatList() async throws -> [Cat] {
        []
    }
    
    func fetchCatDetail(id: String) async throws -> Cat {
        Cat(tags: ["tag1", "tag2"], createdAt: "today", updatedAt: "yesterday", mimetype: "jpg", size: 123, id: "abc", editedAt: nil)
    }
}
