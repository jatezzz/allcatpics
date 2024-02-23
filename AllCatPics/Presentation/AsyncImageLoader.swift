//
//  AsyncImageLoader.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//
import Foundation
import SwiftUI
import Combine

class AsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellables = Set<AnyCancellable>()
    private var cache = URLCache.shared

    func load(fromURL urlString: String) {
        print("working on image", urlString)
        guard let url = URL(string: urlString) else { return }

        // First, attempt to fetch the image from cache
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)){
            print("raw cache image", urlString)
            if let cachedImage = UIImage(data: cachedResponse.data) {
                print("cache image", urlString)
                self.image = cachedImage
                return
            }
        }
        
         print("fetching image", urlString)
        // If not in cache, fetch image from network
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> UIImage? in
                // Cache the fetched data
                let response = output.response
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    self.cache.storeCachedResponse(CachedURLResponse(response: response, data: output.data), for: URLRequest(url: url))
                }
                return UIImage(data: output.data)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
            .store(in: &cancellables)
    }
}
