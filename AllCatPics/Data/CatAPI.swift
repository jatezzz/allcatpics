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
        do {
            let cats = try decoder.decode([Cat].self, from: data)
            return cats
        } catch {
            throw error
        }
    }
    
    func fetchCatDetail(id: String) async throws -> Cat {
        guard let url = URL(string: "https://cataas.com/cat/\(id)?json=true") else {
            fatalError("Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        do {
            let cat = try decoder.decode(Cat.self, from: data)
            return cat
        } catch {
            throw error
        }
    }
}
