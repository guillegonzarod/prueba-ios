//
//  Character.swift
//  prueba-ios
//
//  Created by Guille on 8/1/23.
//

import Foundation

struct CharacterResponseStruct: Decodable {
    var info: InfoStruct?
    var results: [CharacterStruct]?
}

struct InfoStruct: Decodable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
}

struct CharacterStruct: Decodable {
    var id: Int64?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: OriginStruct?
    var location: LocationStruct?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}

struct OriginStruct: Decodable {
    var name: String?
    var url: String?
}

struct LocationStruct: Decodable {
    var name: String?
    var url: String?
}


