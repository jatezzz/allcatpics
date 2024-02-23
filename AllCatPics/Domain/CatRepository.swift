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
    
    func getList() async throws -> [Cat] {
        try await api.fetchCatList()
    }
    
    func getDetail(id: String) async throws -> Cat {
        try await api.fetchCatDetail(id: id)
    }
}
