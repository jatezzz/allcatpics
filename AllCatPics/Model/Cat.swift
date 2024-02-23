//
//  Cat.swift
//  AllCatPics
//
//  Created by John Trujillo on 23/2/24.
//

struct Cat: Identifiable, Decodable {
    let tags: [String]
    let createdAt: String
    let updatedAt: String?
    let mimetype: String
    let size: Int
    let id: String
    let editedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case tags, createdAt, updatedAt, mimetype, size
        case id = "_id"
        case editedAt
    }
}
