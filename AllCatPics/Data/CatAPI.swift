//
//  CatAPI.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatAPIProtocol {
    func fetchCatList(limit: Int, skip: Int) async throws -> [Cat]
    func fetchCatDetail(id: String) async throws -> Cat
}

import Foundation

class CatAPI: CatAPIProtocol {
    func fetchCatList(limit: Int = 10, skip: Int = 0) async throws -> [Cat] {
        guard let url = URL(string: "https://cataas.com/api/cats?limit=\(limit)&skip=\(skip)") else {
            fatalError("Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        // Assuming the API returns an array of Cats. Adjust based on actual response structure.
        do {
            let cats = try decoder.decode([Cat].self, from: data)
            return cats
        } catch {
            throw error
        }
    }
    
    func fetchCatDetail(id: String) async throws -> Cat {
//        Cat(tags: ["tag1", "tag2"], createdAt: "today", updatedAt: "yesterday", mimetype: "jpg", size: 123, id: "abc", editedAt: nil)
        guard let url = URL(string: "https://cataas.com/cat/\(id)?json=true") else {
            fatalError("Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        // Assuming the API returns an array of Cats. Adjust based on actual response structure.
        do {
            let cat = try decoder.decode(Cat.self, from: data)
            return cat
        } catch {
            throw error
        }
    }
}
