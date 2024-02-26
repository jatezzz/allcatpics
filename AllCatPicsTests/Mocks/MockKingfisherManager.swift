//
//  MockKingfisherManager.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 26/2/24.
//

import Kingfisher
import Foundation
@testable import AllCatPics

class MockKingfisherManager: KingfisherManagerProtocol {
    
    func retrieveImage(with resource: Resource,
                       options: KingfisherOptionsInfo?,
                       progressBlock: DownloadProgressBlock?,
                       downloadTaskUpdated: DownloadTaskUpdatedBlock?,
                       completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask? {
        //Just failing scenarios can be tested due to internal protection of RetrieveImageResult
        let error = KingfisherError.requestError(reason: .invalidURL(request: URLRequest(url: resource.downloadURL)))
        let result: Result<RetrieveImageResult, KingfisherError> = .failure(error)
        completionHandler?(result)
        return nil
    }
}
