//
//  MockImageSaver.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 26/2/24.
//

import Foundation
import UIKit
@testable import AllCatPics

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
