//
//  CatAPI.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation

protocol CatAPIProtocol {
    func fetchCatList(limit: Int, skip: Int) async -> Result<[Cat], Error>
    func fetchCatDetail(id: String) async -> Result<Cat, Error>
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
import Foundation

class CatAPI: CatAPIProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchCatList(limit: Int = 10, skip: Int = 0) async -> Result<[Cat], Error> {
        guard let url = URL(string: "https://cataas.com/api/cats?limit=\(limit)&skip=\(skip)") else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(URLError(.badServerResponse))
            }
            
            let decoder = JSONDecoder()
            let cats = try decoder.decode([Cat].self, from: data)
            return .success(cats)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchCatDetail(id: String) async -> Result<Cat, Error> {
        guard let url = URL(string: "https://cataas.com/cat/\(id)?json=true") else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(URLError(.badServerResponse))
            }
            
            let decoder = JSONDecoder()
            let cat = try decoder.decode(Cat.self, from: data)
            return .success(cat)
        } catch {
            return .failure(error)
        }
    }
}
