//
//  CatRepository.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

class CatRepository {
    private let api: CatAPIProtocol
    private let localStorage: CatLocalStorageProtocol
    
    init(api: CatAPIProtocol, localStorage: CatLocalStorageProtocol) {
        self.api = api
        self.localStorage = localStorage
    }
    
    func getList(limit: Int, skip: Int) async throws -> [Cat] {
        try await api.fetchCatList(limit: limit, skip: skip)
    }
    
    func getDetail(id: String) async throws -> Cat {
        // Implement detail fetching logic, including caching
        try await api.fetchCatDetail(id: id)
    }
}
