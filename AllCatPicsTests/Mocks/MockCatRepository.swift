//
//  MockCatRepository.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

import Foundation
@testable import AllCatPics
import UIKit
import Kingfisher

class MockKingfisherManager: KingfisherManagerProtocol {
    
//    var shouldSucceed: Bool = true
    
    func retrieveImage(with resource: Resource,
                       options: KingfisherOptionsInfo?,
                       progressBlock: DownloadProgressBlock?,
                       downloadTaskUpdated: DownloadTaskUpdatedBlock?,
                       completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask? {
        // Mocking the behavior of the retrieveImage function based on the 'shouldSucceed' flag
//        if shouldSucceed {
//           
//        } else {
            let error = KingfisherError.requestError(reason: .invalidURL(request: URLRequest(url: resource.downloadURL)))
            let result: Result<RetrieveImageResult, KingfisherError> = .failure(error)
            completionHandler?(result)
//        }
        return nil // Return a nil DownloadTask as this is just a mock
    }
}


class MockCatRepository: CatRepositoryProtocol {
    var catsToReturn: [Cat] = []
    var catToReturn: Cat!
    var errorToThrow: Error?
    var didAttemptToFetchCats = false
    
    func getDetail(id: String) async throws -> AllCatPics.Cat {
        try await Task.sleep(nanoseconds: 100_000_000) // 100ms
        if let error = errorToThrow {
            throw error
        }
        return catToReturn
    }
    
    func getList(page: Int) async throws -> [Cat] {
        try await Task.sleep(nanoseconds: 100_000_000) // 100ms
        
        if let error = errorToThrow {
            throw error
        }
        return catsToReturn
    }
    
}

class MockImageSaver: ImageSaverProtocol {
    var success: Bool!
    var onSuccess: (() -> Void)?
    var onFailure: ((Error) -> Void)?
    var errorToThrow: Error!
    func saveImage(_ image: UIImage) {
        if success {
            onSuccess?()
        } else {
            onFailure?(errorToThrow)
        }
        
    }
}
