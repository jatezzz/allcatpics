//
//  Cat.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

struct Cat: Identifiable, Decodable, Hashable {
    let tags: [String]
    let createdAt: String?
    let updatedAt: String?
    let mimetype: String?
    let size: Int?
    let id: String
    let editedAt: String?

    var displayName: String = ""

    enum CodingKeys: String, CodingKey {
        case tags, createdAt, updatedAt, mimetype, size, editedAt
        case id = "_id"
    }

    var updatedDate: String? {
        updatedAt ?? editedAt
    }

    var validTags: [String] {
        tags.filter {!$0.isEmpty}
    }
}
