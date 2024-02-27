//
//  Cat+Extension.swift
//  AllCatPicsTests
//
//  Created by John Trujillo on 23/2/24.
//

@testable import AllCatPics

extension Cat {
    static func make(tags: [String] = ["tag1", "tag2"],
                     createdAt: String = "",
                     updatedAt: String = "",
                     mimetype: String = "",
                     size: Int = 12,
                     id: String = "123",
                     editedAt: String = "") -> Cat {

        return Cat(tags: tags, createdAt: createdAt, updatedAt: updatedAt, mimetype: mimetype, size: size, id: id, editedAt: editedAt)
    }
}
