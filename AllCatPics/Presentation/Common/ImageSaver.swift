//
//  ImageSaver.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    let onFailure: (Error)->Void
    init(onFailure: @escaping (Error) -> Void) {
        self.onFailure = onFailure
    }

    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedImage(_:error:context:)), nil)
    }

    @objc func savedImage(_ im: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if let err = error {
            print("Error saving image: \(err)")
            return
        }
        print("Image saved successfully.")
    }
}
