//
//  ImageSaver.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import Foundation
import UIKit

protocol ImageSaverProtocol {
    func saveImage(_ image: UIImage)
}

class ImageSaver: NSObject, ImageSaverProtocol {
    let onFailure: (Error)->Void
    let onSuccess: ()->Void
    init(onFailure: @escaping (Error) -> Void, onSuccess: @escaping ()->Void) {
        self.onFailure = onFailure
        self.onSuccess = onSuccess
    }

    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage(_:error:context:)), nil)
    }

    @objc func savedImage(_ im: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if let error {
            print("Error saving image: \(error)")
            onFailure(error)
            return
        }
        print("Image saved successfully.")
        onSuccess()
    }
}
