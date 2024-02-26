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

class CatAPI: CatAPIProtocol {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchCatList(limit: Int = 10, skip: Int = 0) async -> Result<[Cat], Error> {
        await performRequest(to: CatAPIEndpoints.catList(limit: limit, skip: skip))
    }
    
    func fetchCatDetail(id: String) async -> Result<Cat, Error> {
        await performRequest(to: CatAPIEndpoints.catDetail(id: id))
    }
    
    private func performRequest<T: Decodable>(to urlString: String) async -> Result<T, Error> {
        guard let url = URL(string: urlString) else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(URLError(.badServerResponse))
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
        } catch {
            return .failure(error)
        }
    }
}
