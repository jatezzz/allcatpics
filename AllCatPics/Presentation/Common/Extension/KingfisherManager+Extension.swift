//
//  KingfisherManager+Extension.swift
//  AllCatPics
//
//  Created by John Trujillo on 26/2/24.
//

import Foundation

import Kingfisher
import UIKit

protocol KingfisherManagerProtocol {
    @discardableResult
    func retrieveImage(
        with resource: Resource,
        options: KingfisherOptionsInfo? ,
        progressBlock: DownloadProgressBlock? ,
        downloadTaskUpdated: DownloadTaskUpdatedBlock? ,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask?
}

extension KingfisherManager: KingfisherManagerProtocol {}
